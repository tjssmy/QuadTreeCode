function [lines] = DrawQTBlock(block,links,outline,kval)

QTGlobals 


dx2 = block.dx/2;
dy2 = block.dy/2;

x = block.x;
y = block.y;

x1 = x - dx2;
x2 = x + dx2;
y1 = y - dy2;
y2 = y + dy2;

if outline && ~kval 
    lines{1} = line([x1 x1 x2 x2 x1],[y1 y2 y2 y1 y1],...
        [1 1 1 1 1],'LineWidth',2,'Color','k');
end

if kval
    
    ind = ceil(kQTColormapSize*block.data(KVAL));
    ind = max(1,ind);
    ind = min(ind,kQTColormapSize);
    color = kQTColormap(ind,:);
    
    
    if outline
        lines{2} = patch([x1 x1 x2 x2 x1],[y1 y2 y2 y1 y1],color);
    else
        lines{2} = patch([x1 x1 x2 x2 x1],[y1 y2 y2 y1 y1],color,'EdgeColor','none');
    end
end

if links
    for br=1:MAX_NUM_BR
        if block.br(br)
            xp = Blocks{block.br(br)}.x;
            yp = Blocks{block.br(br)}.y;
            lines{end+1} = line([x xp],[y yp],[1 1],...
                'LineWidth',1,'Color','r','LineStyle','-.');
        end
    end
end
end
