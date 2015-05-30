function DrawQTBlocks(links)

QTGlobals
EraseQTMesh

for b=1:nBlocks
    if b~= 0
        lines = DrawQTBlock(Blocks{b},links);
        FigMesh = {FigMesh{:} lines{:}};
    end
end