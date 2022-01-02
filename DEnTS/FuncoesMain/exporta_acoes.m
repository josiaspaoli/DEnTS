function [] = exporta_acoes(f)

    %#ok<*NASGU>
 
    global G_inputs;
    global G_outputs;
    global G_cont;
    
    emptyCells = cellfun('isempty', G_inputs); 
    G_inputs(all(emptyCells,2),:) = [];    
    G_outputs(G_cont+1:end) = [];
    
    save(f,'G_inputs','G_outputs');
    
    G_cont = 0;
    G_inputs = cell(5000,4);
    G_outputs = zeros(5000,1);

end

