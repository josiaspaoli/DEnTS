function [cartaalta] = verifica_carta_alta(cartas)

    cartaalta = fliplr(find(sum(cartas,1)));

end

