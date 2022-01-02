function[posPreFlop] = verifica_posicao_preflop(Posicao, JogadoresAtivos)

    switch JogadoresAtivos
        case 7
            switch Posicao
                case 0
                    posPreFlop = 2;
                case 1
                    posPreFlop = 1;
                case 2
                    posPreFlop = 1;
                case 3
                    posPreFlop = 4;
                case 4
                    posPreFlop = 4;
                case 5
                    posPreFlop = 3;
                case 6
                    posPreFlop = 3;
                otherwise
                    posPreFlop = 2;
            end
        case 6
            switch Posicao
                case 0
                    posPreFlop = 2;
                case 1
                    posPreFlop = 1;
                case 2
                    posPreFlop = 1;
                case 3
                    posPreFlop = 4;
                case 4
                    posPreFlop = 4;
                case 5
                    posPreFlop = 5;
                otherwise
                    posPreFlop = 2;
            end
        case 5
            switch Posicao
                case 0
                    posPreFlop = 2;
                case 1
                    posPreFlop = 1;
                case 2
                    posPreFlop = 1;
                case 3
                    posPreFlop = 4;
                case 4
                    posPreFlop = 4;
                otherwise
                    posPreFlop = 3;
            end
        case 4
            switch Posicao
                case 0
                    posPreFlop = 3;
                case 1
                    posPreFlop = 1;
                case 2
                    posPreFlop = 1;
                case 3
                    posPreFlop = 4;
                otherwise
                    posPreFlop = 4;
            end
        case 3
            switch Posicao
                case 0
                    posPreFlop = 3;
                case 1
                    posPreFlop = 1;
                case 2
                    posPreFlop = 1;
                otherwise
                    posPreFlop = 4;
            end
        case 2
            switch Posicao
                case 0
                    posPreFlop = 3;
                case 1
                    posPreFlop = 3;
                otherwise
                    posPreFlop = 1;
            end
        otherwise
            switch Posicao
                case 0
                    posPreFlop = 2;
                otherwise
                    posPreFlop = 1;
            end
    end

end