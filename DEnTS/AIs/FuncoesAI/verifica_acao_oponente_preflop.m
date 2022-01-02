function[acaoOponPreFlop] = verifica_acao_oponente_preflop(Pot, ValorCall, SuaAposta, BigBlind)

    if Pot/BigBlind <= 1.5
        acaoOponPreFlop = 1;
    elseif ValorCall <= BigBlind
        acaoOponPreFlop = 2;    
    elseif SuaAposta == 0
        acaoOponPreFlop = 3;
    else
        acaoOponPreFlop = 4;
    end
        
end