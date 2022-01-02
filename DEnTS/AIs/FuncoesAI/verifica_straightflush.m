function [straightflush,faltando] = verifica_straightflush(cartas,situacao)

    straightflush = [];
    faltando = [];
    [naipe,flush] = verifica_flush(cartas,situacao);
    
    if ~isempty(naipe) && length(flush) > 3
        [straightflush,faltando] = verifica_straight(cartas(naipe,:),situacao);       
    end

end

