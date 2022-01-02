function[sequencias,faltando] = verifica_straight(cartas,situacao)

    cartasSeq = sum(cartas,1);
    cartasSeq(cartasSeq~=0) = 1;
    cartasSeq(1) = cartasSeq(14);

    sequencias = zeros(10,5);
    faltando = zeros(10,5);
    temp = ones(1,10)*5;
    for i=1:size(sequencias,1)
        faltandoTemp = 5-size(find(cartasSeq(i:i+4)),2);
        if faltandoTemp <= situacao
            sequencias(i,:) = (i:i+4).*cartasSeq((i:i+4));
            faltando(i,:) = abs((i:i+4).*(cartasSeq((i:i+4))-1));
            temp(i) = size(find(faltando(i,:)),2);
        end
    end
    numMinFalta = min(temp);

    for i=1:size(sequencias,1)
        if size(find(faltando(i,:)),2) > numMinFalta
            sequencias(i,:) = zeros(1,5);
            faltando(i,:) = zeros(1,5);
        end
    end

    if size(sequencias,1) > 1
        for i=1:size(sequencias,1)-1
            x = find(faltando(i,:));
            y = find(faltando(i+1,:));
            if ~isempty(x) && ~isempty(y)
                if faltando(i,x) == faltando(i+1,y) %#ok<FNDSB>
                    sequencias(i,:) = zeros(1,5);
                    faltando(i,:) = zeros(1,5);
                end
            end
        end
    end

    sequencias(all(~sequencias,2),:) = [];
    faltando(all(~faltando,2),:) = [];

end