function [aposta] = Human(cartas,dados,estado,historico)

    while true

        aposta = input('');
        if ~isempty(aposta) && isa(aposta,'double') 
            break;
        end
        fprintf('Enter a valid amount\n')

    end

    armazena_acao(cartas, dados, estado, historico, aposta);

end

