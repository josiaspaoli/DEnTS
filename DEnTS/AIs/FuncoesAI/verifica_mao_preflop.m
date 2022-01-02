function[maoPreFlop] = verifica_mao_preflop(cartas)
    
    cartaalta = verifica_carta_alta(cartas);
    [tipo,~] = verifica_agrupamentos_por_valor(cartas);
    naipado = logical(max(sum(cartas,2))-1);
    
    if tipo == 1
        if cartaalta(1) > 12
            maoPreFlop = 1;
        elseif cartaalta(1) == 12
            maoPreFlop = 2;
        elseif cartaalta(1) < 12 && cartaalta(1) > 8
            maoPreFlop = 4;
        elseif cartaalta(1) <= 8
            maoPreFlop = 5;
        end
    else
        if cartaalta(1) == 14
            if cartaalta(2) == 13
                maoPreFlop = 3;
            elseif cartaalta(2) < 13 && cartaalta(2) > 9
                maoPreFlop = 6;
            else
                if naipado
                    maoPreFlop = 7;
                else
                    maoPreFlop = 10;
                end
            end
        elseif cartaalta(1) > 10 && cartaalta(2) > 9
            maoPreFlop = 8;
        elseif cartaalta(1)-cartaalta(2) == 1 && cartaalta(2) > 3
            maoPreFlop = 9;
        else
            maoPreFlop = 10;
        end    
    end
    
end