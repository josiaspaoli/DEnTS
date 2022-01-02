function[acaoOponFTR] = verifica_acao_oponente_FTR(ValorCall, SuaAposta)

    if ValorCall == 0
        acaoOponFTR = 1;
    elseif SuaAposta == 0
        acaoOponFTR = 2;    
    else
        acaoOponFTR = 3;
    end
        
end