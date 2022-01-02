function[chance,somachance] = calcula_chance_de_melhora(situacao,tipo,straight,faltandoSt,flush,straightflush)

    if situacao == 0
        chance = 0;
        somachance = 0;
        return
    end

    chance = zeros(1,6); 
    cps = situacao; % cartas para sair
    ctotal = 52; % total de cartas do baralho
    cfinal = 7; % se revela 7 cartas ao fim
    A = ctotal - (cfinal - cps); % cartas não vistas
    %  cfavoraveis = número de cartas que melhora sua mão

    % Analise para straightflush
    if ~isempty(straightflush)
        cfavoraveis = zeros(1,size(straightflush,1));
        pchance = zeros(1,size(straightflush,1));
        for i=1:size(straightflush,1)
            if nnz(straightflush(i,:)) == 3
                cfavoraveis(i) = 2;
                pchance(i) = (cfavoraveis(i)/A)*((cfavoraveis(i)-1)/(A-1));
            end
            if nnz(straightflush(i,:)) == 4
                cfavoraveis(i) = 1;
                if cps == 1
                    pchance(i) = cfavoraveis(i)/A;
                else
                    pchance(i) = 1-((A-cfavoraveis(i))/A)*((A-cfavoraveis(i)-1)/(A-1));
                end
            end
        end
        chance(6) = sum(pchance);
    else
        straightflush = 1;
    end

    %  chance de melhorar para um four of a kind partindo de trinca ou full house
    if (tipo==3 || tipo==4) && nnz(straightflush(1,:))~=5
        cfavoraveis = 1;
        if cps == 1
            chance(5) = cfavoraveis/A;
        else
            chance(5) = 1-((A-cfavoraveis)/A)*((A-(cfavoraveis+1))/(A-1));
        end 
    end

    %  chance de melhorar para um full house partindo de trinca
    if tipo==3 && nnz(straightflush(1,:))~=5
        cfavoraveis = 6;
        if cps == 1
            chance(4) = (cfavoraveis+3)/A;
        else
            chance(4) = 1-((A-cfavoraveis)/A)*((A-(cfavoraveis+3))/(A-1));
        end 
    end

    % chance de melhorar para um full house partindo de dois pares
    if tipo == 2 && nnz(straightflush(1,:))~=5
        cfavoraveis = 4;
        if cps == 1
            chance(4) = cfavoraveis/A;
        else
            chance(4) = 1-((A-cfavoraveis)/A)*((A-cfavoraveis-1)/(A-1));
        end 
    end

    % Analise para flush
    if ~isempty(flush) && nnz(straightflush(1,:))~=5 && tipo~=5 && tipo~=4
        if length(flush) == 3
            cfavoraveis = 10;
            chance(3) = (cfavoraveis/A)*((cfavoraveis-1)/(A-1));
        end
        if length(flush) == 4
            cfavoraveis = 9;
            if cps == 1
                chance(3) = cfavoraveis/A;
            else
                chance(3) = 1-((A-cfavoraveis)/A)*((A-cfavoraveis-1)/(A-1));
            end
        end
    else
        flush = 1;
    end
    
    % Analise para straight
    if ~isempty(faltandoSt) && nnz(straightflush(1,:))~=5 && tipo~=5 && tipo~=4 && nnz(flush(1,:))~=5
        cfavoraveis = zeros(1,size(faltandoSt,1));
        pchance = zeros(1,size(faltandoSt,1));
        for i=1:size(faltandoSt,1)
            if nnz(faltandoSt(1,:)) == 3
                cfavoraveis(i) = 8;
                pchance(i) = (cfavoraveis(i)/A)*((cfavoraveis(i)-4)/(A-1));
            end
            if nnz(faltandoSt(1,:)) == 4
                cfavoraveis(i) = 4;
                if cps == 1
                    pchance(i) = cfavoraveis(i)/A;
                else
                    pchance(i) = 1-((A-cfavoraveis(i))/A)*((A-cfavoraveis(i)-1)/(A-1));
                end
            end
        end
        chance(2) = sum(pchance);
    else
        straight = 1;
    end

    % chance de melhoras para uma trinca
    if tipo == 1 && nnz(straightflush(1,:))~=5 && nnz(flush(1,:))~=5 && nnz(straight(1,:))~=5
        cfavoraveis = 2;
        if cps == 1
            chance(1) = cfavoraveis/A;
        else
            chance(1) = 1-((A-cfavoraveis)/A)*((A-cfavoraveis-1)/(A-1));
        end 
    end

%{
    % chance de melhora para dois pares
    if tipo == 1 && length(strrep(straightflush(1,:),'0',''))~=5 && length(strrep(flush(1,:),'0',''))~=5 && length(strrep(straight(1,:),'0',''))~=5
        cfavoraveis = 9;
        if cps == 1
            chance(2) = (cfavoraveis+3)/A;
        else
            chance(2) = 1-((A-cfavoraveis)/A)*((A-(cfavoraveis+3))/(A-1));
        end 
    end

    % chance de se fazer um par
    if tipo == 0 && length(strrep(straightflush(1,:),'0',''))~=5 && length(strrep(flush(1,:),'0',''))~=5 && length(strrep(straight(1,:),'0',''))~=5
        cfavoraveis = 15;
        if cps == 1
            chance(1) = (cfavoraveis+3)/A;
        else
            chance(1) = 1-((A-cfavoraveis)/A)*((A-(cfavoraveis+3))/(A-1));
        end 
    end
%}

    if chance(2)~=0 && chance(3)~=0
        if cps == 1
            somachance = sum(chance) - (1/A);
        elseif nnz(flush(1,:))==3 && nnz(straight(1,:))==3
            somachance = sum(chance) - (2/A)*(1/(A-1))*size(faltandoSt,1);
        elseif nnz(flush(1,:))==3 && nnz(straight(1,:))==4
            somachance = sum(chance) - chance(3)*(1-(9/10)*(8/9));
        elseif nnz(flush(1,:))==4 && nnz(straight(1,:))==3
            somachance = sum(chance) - chance(2)*(1-(3/4)*(3/4));
        else
            somachance = sum(chance) - 2*chance(6);
        end
    else
        somachance = sum(chance);
    end
end