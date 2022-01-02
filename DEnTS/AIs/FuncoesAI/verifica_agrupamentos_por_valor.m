function[tipo,valor] = verifica_agrupamentos_por_valor(cartas)

    qtdCartas = sum(cartas);
    qtdMaior = max(qtdCartas);
    
    switch qtdMaior
        case 1
            tipo = 0;
            valor = 0;
        case 2
            pares = find(qtdCartas==2);
            if size(pares) == 1
                tipo = 1;
                valor = pares;
            else
                tipo = 2;
                valor = [pares(end) pares(end-1)];
            end
        case 3
            trincas = find(qtdCartas==3);
            ordemQtdCartas = sort(qtdCartas,'descend');
            if nnz(ordemQtdCartas) == 1
                tipo = 3;
                valor = trincas(end);
            elseif ordemQtdCartas(2) == 1
                tipo = 3;
                valor = trincas(end);
            elseif ordemQtdCartas(2) == 2
                pares = find(qtdCartas==2);
                tipo = 4;
                valor = [trincas(end) pares(end)];
            elseif ordemQtdCartas(2) == 3
                tipo = 4;
                valor = [trincas(end) trincas(end-1)];
            end
        otherwise
            quadra = find(qtdCartas==4);
            tipo = 5;
            valor = quadra;
    end

end