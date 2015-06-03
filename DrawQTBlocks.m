function DrawQTBlocks(blocks,links,outline,kval,nodes)

QTGlobals
% EraseQTMesh
fprintf('Drawing Blocks: ');

axis([0 QTXmax 0 QTYmax]);

if blocks
    for b=1:nBlocks
        if mod(b,500) == 0, fprintf('... %i',b); end
        if mod(b,3500) == 0, fprintf('\n\t\t'); end
        
        lines = DrawQTBlock(Blocks{b},links,outline,kval);
        %         FigMesh = {FigMesh{:} lines{:}};
    end
end


if nodes
    hold on
    DrawQTNodes();
end

fprintf('\n');
end