function [Mcartas] = monta_cartas(cartas)

    Mcartas = zeros(4,14);
    if cartas(1) ~= -1
        Mcartas(floor(cartas(1)/13)+1,rem(cartas(1),13)+1) = 1;
        Mcartas(floor(cartas(2)/13)+1,rem(cartas(2),13)+1) = 1;
    end
    if cartas(3) ~= -1
        Mcartas(floor(cartas(3)/13)+1,rem(cartas(3),13)+1) = 1;
        Mcartas(floor(cartas(4)/13)+1,rem(cartas(4),13)+1) = 1;
        Mcartas(floor(cartas(5)/13)+1,rem(cartas(5),13)+1) = 1;
        if cartas(6) ~= -1
            Mcartas(floor(cartas(6)/13)+1,rem(cartas(6),13)+1) = 1;
            if cartas(7) ~= -1
                Mcartas(floor(cartas(7)/13)+1,rem(cartas(7),13)+1) = 1;
            end
        end
    end
    
    Mcartas(:,14) = Mcartas(:,1);
    Mcartas(:,1) = zeros(4,1);

end

