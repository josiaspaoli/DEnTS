function [resultados, historico, deals, jogadores, tightness, t] = joga(estruturaAposta, jogadores, numTorneios, numJogadores, tightness, flagLogs, flagHuman, f)

    t = zeros(1,numTorneios);
    historico = zeros(5, 4, numJogadores);
    resultados = zeros(numTorneios, numJogadores);
    deals = zeros(numTorneios,1);
    
    fprintf('\n========================= Iniciando torneios: =========================\n');
    
    for ii=1:numTorneios
        
        n = num2str(ii);
        s = strcat(['Torneio', ' ', n]);
        
        if flagLogs
            fC = strcat([f,'/',s],'.txt');
        else
            fC = 'N';
        end
        
        fprintf('\nTorneio %d:', ii);
        
        tic;
        [resultado, historico, deal] = OOPoker(historico, estruturaAposta, jogadores, tightness, fC);
        t(ii) = toc;
        
        resultados(ii,:) = resultado;
        deals(ii) = deal;
        fprintf('\n\nTorneio %d terminado ap�s %d partidas (%.2f segundos). \n', ii, round(deal),t(ii));
        
        formatSpec1 = '    %d� Colocado: AI: %s \n';
        
        for jj=1:numJogadores
            switch (jogadores(resultado == jj))
                case 1
                    str = sprintf('Smart (%.2f)', tightness(resultado == jj));
                case 2
                    str = 'Random';
                case 3
                    str = 'Check/Fold';
                case 4
                    str = 'Call';
                case 5
                    str = 'BlindLimp';
                case 6
                    str = 'Raise';
                case 7
                    str = 'Humano';
                case 11
                    str = 'MyBot1';
                case 21
                    str = 'MyBot2';
                case 31
                    str = 'MyBot3';
                case 41
                    str = 'MyBot4';
                case 51
                    str = 'MyBot5';
                case 61
                    str = 'MyBot6';
                case 71
                    str = 'MyBot7';
                case 81
                    str = 'MyBot8';
                case 91
                    str = 'MyBot9';
                otherwise
                    str = 'MyBot10';
            end
            fprintf(formatSpec1, jj, str);
        end
        clear mex
        
        if flagHuman
            fM = fullfile(f, s);
            exporta_acoes(fM);
        else
            if ii ~= numTorneios
                temp = randperm(size(jogadores,2));
                jogadores = jogadores(temp);
                tightness = tightness(temp);
                historico = historico(:,:,temp);
                resultados = resultados(:,temp);
            end
        end
        
        if ii ~= numTorneios
            fprintf('\n-----------------------------------------------------------------------\n');
        else
            fprintf('\n========================== Fim da simula��o! ==========================\n');
        end
    
    end

end

