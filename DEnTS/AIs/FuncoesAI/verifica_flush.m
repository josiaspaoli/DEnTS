function[naipe,flush] = verifica_flush(cartas,situacao)

    qtdCartasNaipe = sum(cartas,2)';
    
    if max(qtdCartasNaipe) < 3
        naipe = 0;
        flush = 0;
    elseif max(qtdCartasNaipe) == 3
        if situacao < 2
            naipe = 0;
            flush = 0;
        else
            if size(find(qtdCartasNaipe==3)) > 1
                naipe = 0;
                flush = 0;
            else
                naipe = find(qtdCartasNaipe==3);
                flush = find(cartas(naipe,:));
            end
        end
    elseif max(qtdCartasNaipe) == 4
        if situacao < 1
            naipe = 0;
            flush = 0;
        else
            naipe = find(qtdCartasNaipe==4);
            flush = find(cartas(naipe,:));
        end
    elseif max(qtdCartasNaipe) == 5
        naipe = find(qtdCartasNaipe==5);
        flush = find(cartas(naipe,:)); 
    elseif max(qtdCartasNaipe) == 6
        naipe = find(qtdCartasNaipe==6);
        flush = find(cartas(naipe,:));
        flush = flush(end-4:end);
    elseif max(qtdCartasNaipe) == 7
        naipe = find(qtdCartasNaipe==7);
        flush = find(cartas(naipe,:));
        flush = flush(end-4:end);
    end
    
end