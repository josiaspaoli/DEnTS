function[power,pcm,tpcm] = calcula_forca_da_mao(situacao,cartas2,cartaalta,tipo,valor,straight,flush,straightflush)

    mult1 = 0;
    temp = [];
    

    if (~isempty(straightflush) && nnz(straightflush(1,:)) == 5) % straightflush
        temp = straightflush;
        mult1 = 9;
    elseif (tipo==5) % four
        temp = valor(1);
        mult1 = 8;
    elseif (tipo==4) % full house
        temp = valor(1);
        mult1 = 7;
    elseif (~isempty(flush) && nnz(flush) == 5) % flush
        temp = flush;
        mult1 = 6;
    elseif (~isempty(straight) && nnz(straight(1,:)) == 5) % straight
        temp = straight;
        mult1 = 5;
    elseif (tipo==3) %% trinca
        temp = valor(1);
        mult1 = 4;
    elseif (tipo==2) %% 2 pares
        temp = valor(1);
        mult1 = 3;
    elseif (tipo==1) %% par
        temp = valor(1);
        mult1 = 2;
    end

    if isempty(temp)
        power = 0;
    else
        switch max(temp(:))
            case 14
                power = mult1*10 + 10;
            case 13
                power = mult1*10 + 9;
            case 12
                power = mult1*10 + 8;
            case 11
                power = mult1*10 + 7;
            case 10
                power = mult1*10 + 6;
            case 9
                power = mult1*10 + 5;
            case 8
                power = mult1*10 + 4;
            case 7
                power = mult1*10 + 3;
            case {6,5}
                power = mult1*10 + 2;
            case {4,3,2}
                power = mult1*10 + 1;
            otherwise
                power = 0;
        end
    end

    cartaalta2 = verifica_carta_alta(cartas2);
    [tipo2,valor2] = verifica_agrupamentos_por_valor(cartas2);
    [straight2,~] = verifica_straight_cartas_da_mesa(cartas2);
    [~,flush2] = verifica_flush_cartas_da_mesa(cartas2);
    [straightflush2,~] = verifica_straightflush(cartas2,situacao);
    
    crest = 14;   
    if ~isempty(valor2)
        if ~isempty(cartaalta2(cartaalta2~=valor2(1)))
            crest = cartaalta2(cartaalta2~=valor2(1));
            if size(valor2) == 2
                crest = crest(crest~=valor2(2));
            end
        end
    end
    nordem = 2:14;
    if ~isempty(flush2)
        for i=1:length(flush2)
            nordem = nordem(nordem~=flush2(i));
        end
    end

    mult2 = zeros(1,12);
    if (tipo2==5) %% four
        mult2(1) = 1;
    end
    if (tipo2==4) % full house
        mult2(2) = 1;
    end
    if (tipo2==3) %% trinca
        mult2(3) = 1;
    end
    if (tipo2==2) %% 2 pares
        mult2(4) = 1;
    end
    if (~isempty(straightflush2) && nnz(straightflush2(1,:)) == 4) %sfdraw
        mult2(5) = 1;
    end 
    if (~isempty(flush2) && nnz(flush2(1,:)) == 4) % flushdraw
        mult2(6) = 1;
    end 
    if (~isempty(straight2) && nnz(straight2(1,:)) == 4) % straightdraw
        mult2(7) = 1;
    end 
    if (tipo2==1) %% par
        mult2(8) = 1;
    end
%     if (~isempty(flush2) && nnz(flush2(1,:)) == 3) % flush2c
%         mult2(9) = 1;
%     end 
%     if (~isempty(straight2) && nnz(straight2(1,:)) == 3) % straight2c
%         mult2(10) = 1;
%     end
    if (~isempty(straight2) && nnz(straight2(1,:)) == 5) % straightfull
        mult2(9) = 1;
    end
    if (~isempty(flush2) && nnz(flush2(1,:)) == 5) % flushfull
        mult2(10) = 1;
    end
    if (~isempty(straightflush2) && nnz(straightflush2(1,:)) == 5) % straightflushfull
        mult2(11) = 1;
    end
    mult2(12) = 1;
    
    tpcm = zeros(1,12);
    if mult2(1) == 1
        tpcm(1) = 75;
    end

    if mult2(2) == 1
        if mult1 == 8
            if valor(1) == valor2(1)
                tpcm(2) = 100;
            elseif valor(1) >= valor2(1) && valor(1) >= valor2(2)
                tpcm(2) = 100;
            else
                tpcm(2) = 80;
            end
        elseif mult1 == 7
            if valor(1) > valor2(1)
                tpcm(2) = 80;
            else
                tpcm(2) = 60;
            end
        end
    end    

    if mult2(3) == 1
        if mult1 == 4
            tpcm(3) = 50;
        elseif mult1 == 5
            tpcm(3) = 70;
        elseif mult1 == 6
            tpcm(3) = 70;
        elseif mult1 == 7
            if valor(2) >= crest(end)
                tpcm(3) = 90;
            else
                tpcm(3) = 85;
            end
        elseif mult1 == 8
            tpcm(3) = 100;
        elseif mult1 == 9
            tpcm(3) = 100;
        end
    end

    if mult2(4) == 1
        if mult1 == 3
            if valor(2) > valor2(2)
                tpcm(4) = 50;
            else
                tpcm(4) = 25;
            end
        elseif mult1 == 5
            tpcm(4) = 70;
        elseif mult1 == 6
            tpcm(4) = 70;
        elseif mult1 == 7
            if valor(1) >= valor2(1)
                tpcm(4) = 90;
            else
                tpcm(4) = 75;
            end    
        elseif mult1 == 8
            tpcm(4) = 100;
        elseif mult1 == 9
            tpcm(4) = 100;
        end
    end

    if mult2(5) == 1
        if mult1 == 2
            if valor(1) >= cartaalta2(1)
                tpcm(5) = 30;
            else
                tpcm(5) = 15;
            end
        elseif mult1 == 3
            tpcm(5) = 40;
        elseif mult1 == 4
            tpcm(5) = 40;
        elseif mult1 == 5
            tpcm(5) = 60;
        elseif mult1 == 6
            tpcm(5) = 65;
        elseif mult1 == 7
            tpcm(5) = 90;
        elseif mult1 == 8
            tpcm(5) = 90;
        elseif mult1 == 9
            temp = straightflush2(straightflush2~=0);
            if size(straightflush2,1) == 1
                tpcm(5) = 100;
            elseif straightflush(end) > temp(end)
                tpcm(5) = 100; 
            else
                tpcm(5) = 90; 
            end
        end
    end

    if mult2(6) == 1
        if mult1 == 2
            if valor(1) >= cartaalta2(1)
                tpcm(6) = 35;
            else
                tpcm(6) = 25;
            end
        elseif mult1 == 3
            tpcm(6) = 50;
        elseif mult1 == 4
            tpcm(6) = 55;
        elseif mult1 == 5
            tpcm(6) = 55;
        elseif mult1 == 6
            if ~isempty(find(nordem==flush(end),1))
                if find(nordem==flush(end))==1 || find(nordem==flush(end))==2 || find(nordem==flush(end))==3           
                    tpcm(6) = 85;
                else
                    tpcm(6) = 55;
                end
            else
                tpcm(6) = 55;
            end
        elseif mult1 == 7
            tpcm(6) = 90;
        elseif mult1 == 8
            tpcm(6) = 90;
        elseif mult1 == 9
            tpcm(6) = 100;
        end
    end

    if mult2(7) == 1
        if mult1 == 2
            if valor(1) >= cartaalta2(1)
                tpcm(7) = 35;
            else
                tpcm(7) = 25;
            end
        elseif mult1 == 3
            tpcm(7) = 45;
        elseif mult1 == 4
            tpcm(7) = 50;
        elseif mult1 == 5
            temp = straight2(straight2~=0);
            if straight(end) > temp(end)
                tpcm(7) = 85;
            else
                tpcm(7) = 65;
            end
        elseif mult1 == 6
            tpcm(7) = 90;
        elseif mult1 == 7
            tpcm(7) = 100;
        elseif mult1 == 8
            tpcm(7) = 100;
        elseif mult1 == 9
            tpcm(7) = 100;
        end
    end

    if mult2(8) == 1
        if mult1 == 2
            if cartaalta(1) > cartaalta2(1)
                tpcm(8) = 35;
            else
                tpcm(8) = 25;
            end
        elseif mult1 == 3
            if valor(1) > cartaalta2(1)
                tpcm(8) = 65;
            elseif valor(2) >= valor2(1)
                tpcm(8) = 55;
            else
                tpcm(8) = 45;
            end
        elseif mult1 == 4
            tpcm(8) = 75;
        elseif mult1 == 5
            tpcm(8) = 85;
        elseif mult1 == 6
            tpcm(8) = 90;
        elseif mult1 == 7
            tpcm(8) = 90;
        elseif mult1 == 8
            tpcm(8) = 90;
        elseif mult1 == 9  
            tpcm(8) = 100;
        end
    end

%     if mult2(9) == 1
%         if mult1 == 2
%             if valor(1) >= cartaalta2(1)
%                 tpcm(9) = 60;
%             else
%                 tpcm(9) = 30;
%             end
%         elseif mult1 == 3
%             tpcm(9) = 70;
%         elseif mult1 == 4
%             tpcm(9) = 80;
%         elseif mult1 == 5
%             tpcm(9) = 85;
%         elseif mult1 == 6
%             tpcm(9) = 85;
%         elseif mult1 == 7
%             tpcm(9) = 90;
%         elseif mult1 == 8
%             tpcm(9) = 90;
%         elseif mult1 == 9
%             tpcm(9) = 100;
%         end
%     end
% 
%     if mult2(10) == 1
%         if mult1 == 2
%             if valor(1) >= cartaalta2(1)
%                 tpcm(10) = 45;
%             else
%                 tpcm(10) = 35;
%             end
%         elseif mult1 == 3
%             tpcm(10) = 70;
%         elseif mult1 == 4
%             tpcm(10) = 80;
%         elseif mult1 == 5
%             tpcm(10) = 85;
%         elseif mult1 == 6
%             tpcm(10) = 85;
%         elseif mult1 == 7
%             tpcm(10) = 90;
%         elseif mult1 == 8
%             tpcm(10) = 90;
%         elseif mult1 == 9
%             tpcm(10) = 100;
%         end
%     end

    if mult2(9) == 1
        if mult1 == 5
            if straight(end) > straight2(end)
                tpcm(9) = 100;
            else
                tpcm(9) = 80;
            end
        elseif mult1 == 9
            tpcm(9) = 100;
        end
    end

    if mult2(10) == 1
        if mult1 == 6
            if flush(end) > flush2(end)
                tpcm(10) = 100;
            else
                tpcm(10) = 80;
            end
        elseif mult1 == 9
            tpcm(10) = 100;
        end
    end

    if mult2(11) == 1
        if mult1 == 9
            if straightflush(end) > straightflush2(end)
                tpcm(11) = 100; 
            else
                tpcm(11) = 80; 
            end
        end
    end
    
    if mult2(12) == 1
        if mult1 == 0
            if cartaalta(1) >= 12
                tpcm(12) = 25;
            else
                tpcm(12) = 10;
            end
        elseif mult1 == 2
            if valor(1) >= cartaalta2(1)
                tpcm(12) = 55;
            else
                tpcm(12) = 37;
            end
        elseif mult1 == 3
            if valor(1) == cartaalta2(1)
                tpcm(12) = 80;
            else
                tpcm(12) = 65;
            end
        elseif mult1 == 4
            tpcm(12) = 80;
        elseif mult1 == 5
            tpcm(12) = 85;
        else
            tpcm(12) = 100;
        end
    end
    
    pcm = min(tpcm(tpcm~=0));
    
end
    



