function[Od] = odds_preflop_headsup(cartas)
    
    cartaalta = verifica_carta_alta(cartas);
    [tipo,~] = verifica_agrupamentos_por_valor(cartas);
    naipado = logical(max(sum(cartas,2))-1);
    

    if tipo == 1
        load('pfoffsuit.txt');
        Od = pfoffsuit(cartaalta-1,cartaalta-1);
    elseif naipado
        load('pfsuited.txt');
        Od = pfsuited(cartaalta(1)-1,cartaalta(2)-1);
    else
        load('pfoffsuit.txt');
        Od = pfoffsuit(cartaalta(1)-1,cartaalta(2)-1);
    end 
    
end