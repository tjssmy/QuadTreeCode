function GetQTBlockSurfaces(var)

QTGlobals

fprintf('Generating Block Surfaces (%i): ',var);

for b=1:nBlocks
    if mod(b,500) == 0, fprintf('... %i',b); end
    Blocks{b} = GetQTBlockSurface(Blocks{b},var);
end

fprintf('\n');

end

function [block] = GetQTBlockSurface(block,var)

QTGlobals

dx2 = block.dx/2;
dy2 = block.dy/2;

x = block.x;
y = block.y;

[i1,i2,j1,j2] = GetQTKfctRange(x,y,dx2,dy2);

[sf,~,~] = GetBlockVsurface(block,var);

block.sf{var} = sf;

end


function [sf,d,v] = GetBlockVsurface(block,var)

QTGlobals

x(1) = block.x;
y(1) = block.y;
v(1) = block.data(var);

for br = 1:MAX_NUM_BR
    if block.br(br)
        oBl = Blocks{block.br(br)};
        x(end+1) = oBl.x;
        y(end+1) = oBl.y;
        v(end+1) = oBl.data(var);
        for br2 = 1:MAX_NUM_BR
            if oBl.br(br2)
                x(end+1) = Blocks{oBl.br(br2)}.x;
                y(end+1) = Blocks{oBl.br(br2)}.y;
                v(end+1) = Blocks{oBl.br(br2)}.data(var);
            end
        end 
        
        [x,y,v] = AddQTBlockSurfacePnts(oBl, x,y,v,var);
        
    end
end

[x,y,v] = AddQTBlockSurfacePnts(block, x,y,v,var);


[d,c] = unique([x',y'],'rows');
v = v(c);

sf = fit(d,v','cubicinterp');

end
