function [aposta] = AI4(cartas,dados,estado,historico)

    BB = dados(1);
    stack = dados(2);
    posicao = dados(3);
    %indexDealer = dados(4);
    %indexPlayer = dados(5);
    situacao = dados(6);
    pot = dados(7);
    wagerJogador = dados(8);
    valorCall = dados(9);
    minRaise = dados(10);
    jogadoresAtivos = dados(11);
    %jogadoresDecidindo = dados(12);

    Mcartas = monta_cartas(cartas);
    
    oponentesAgressivos = zeros(1,jogadoresAtivos-1);    
    indiceJogadores = find(estado(1,:)~=posicao);
    cont = 1;    
    for ii=indiceJogadores
        numJogadasAgrPF = sum(historico(3:5,1,ii));
        numJogadasPF = sum(historico(:,1,ii));
        if numJogadasAgrPF/numJogadasPF >= 0.9 && numJogadasPF > 250
            oponentesAgressivos(cont) = 1;
        end
        cont = cont+1;
    end    
    AgressividadeMesa = sum(oponentesAgressivos);

    if situacao == 1

        posPreFlop = verifica_posicao_preflop(posicao+1, jogadoresAtivos);
        maoPreFlop = verifica_mao_preflop(Mcartas);
        acaoOponPreFlop = verifica_acao_oponente_preflop(pot, valorCall, wagerJogador, BB);

        if jogadoresAtivos ~= 2
            fuzzyPF = readfis('preflop.fis');
            
            acaoPreFlop = int8(evalfis([maoPreFlop posPreFlop acaoOponPreFlop (stack/BB)*10e-3]',fuzzyPF));
            switch acaoPreFlop
                case 1
                    aposta = 0;
                case 2
                    aposta = valorCall;
                case 3
                    if AgressividadeMesa ~= 0
                        aposta = stack;
                    else
                        aposta = valorCall + 1.5*minRaise;
                    end
                otherwise
                    if AgressividadeMesa ~= 0
                        aposta = stack;
                    else
                        aposta = valorCall + 3*minRaise;
                    end
            end
        else
            if posPreFlop == 2 % Dealer
                acaoPreFlop = calcula_acao_dealer_headsup(Mcartas, BB, valorCall, stack, pot);
            else % SB
                acaoPreFlop = calcula_acao_smallblind_headsup(Mcartas, BB, valorCall, stack, pot);
            end

            switch acaoPreFlop
                case 1
                    aposta = 0;
                case 11
                    aposta = valorCall;
                case 21
                    if AgressividadeMesa ~= 0
                        aposta = stack;
                    else
                        aposta = valorCall + 1.5*minRaise;
                    end
                case {31, 41}
                    if AgressividadeMesa ~= 0
                        aposta = stack;
                    else
                        aposta = valorCall + 3*minRaise;
                    end
                case 51
                    aposta = stack;
                otherwise
            end
        end

    else
        
        fuzzyFTR = readfis('ftr.fis');
        
        cartasFaltando = 7 - sum(sum(Mcartas));
        cartaalta = verifica_carta_alta(Mcartas);
        [tipo,valor] = verifica_agrupamentos_por_valor(Mcartas);
        [straight,faltandoSt] = verifica_straight(Mcartas,cartasFaltando);
        [~,flush] = verifica_flush(Mcartas,cartasFaltando);
        [straightflush,~] = verifica_straightflush(Mcartas,cartasFaltando);

        Mcartas2 = monta_cartas([-1, -1, cartas(3:7)]);

        [~,somachance] = calcula_chance_de_melhora(cartasFaltando,tipo,straight,faltandoSt,flush,straightflush);
        [acaoOponFTR] = verifica_acao_oponente_FTR(valorCall, wagerJogador);
        [~,pcm,~] = calcula_forca_da_mao(cartasFaltando,Mcartas2,cartaalta,tipo,valor,straight,flush,straightflush);
        acaoFTR = int8(evalfis([(stack/BB)*10e-3 pcm acaoOponFTR (valorCall/BB)*10e-3 somachance]',fuzzyFTR));

        switch acaoFTR
            case 1
                aposta = 0;
            case 2
                aposta = valorCall;
            case 3
                if AgressividadeMesa ~= 0
                    aposta = stack;
                else
                    aposta = valorCall + 2*minRaise;
                end
            otherwise
                aposta = stack;
        end

    end
    
end

