function RefineQTBlocks(maxNumLevels,kThresh)

QTGlobals

fprintf('Refining Blocks: %i ',nBlocks);

for n=1:maxNumLevels
    
    currentnBlocks = nBlocks;
    for b=1:currentnBlocks
        RefineQTBlock(b,kThresh);
    end
    fprintf('... %i',nBlocks);
%     DrawQTBlocks

end

fprintf('\n');

end

