function DrawQTBlocks(blocks,links,outline,kval,nodes)

QTGlobals
% EraseQTMesh

axis([0 QTXmax 0 QTYmax]);

if blocks
    for b=1:nBlocks
        lines = DrawQTBlock(Blocks{b},links,outline,kval);
%         FigMesh = {FigMesh{:} lines{:}};
    end
end

if nodes
    hold on
    DrawQTNodes();
end

end