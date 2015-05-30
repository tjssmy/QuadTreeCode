function RefineQTBlocks(maxNumLevels,kThresh)

QTGlobals

for n=1:maxNumLevels
    currentnBlocks = nBlocks
    for b=1:currentnBlocks
        RefineQTBlock(b,kThresh);
    end
    
%     DrawQTBlocks

end


end

