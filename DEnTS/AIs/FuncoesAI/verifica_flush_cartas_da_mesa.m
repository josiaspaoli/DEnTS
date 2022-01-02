function[naipe,flush] = verifica_flush_cartas_da_mesa(cartas)

    qtdCartasNaipe = sum(cartas,2)';
    
    if max(qtdCartasNaipe) < 3
        naipe = 0;
        flush = 0;
    elseif max(qtdCartasNaipe) == 3
            if size(find(qtdCartasNaipe==3)) > 1
                naipe = 0;
                flush = 0;
            else
                naipe = find(qtdCartasNaipe==3);
                flush = find(cartas(naipe,:));
            end
    elseif max(qtdCartasNaipe) == 4
            naipe = find(qtdCartasNaipe==4);
            flush = find(cartas(naipe,:));
    elseif max(qtdCartasNaipe) == 5
        naipe = find(qtdCartasNaipe==5);
        flush = find(cartas(naipe,:)); 
    end
    
end