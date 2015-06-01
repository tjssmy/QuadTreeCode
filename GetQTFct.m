function GetQTFct(var,mode)

QTGlobals

for b=1:nBlocks
    SetQTFctBlock(Blocks{b},var,mode);
end

end

function SetQTFctBlock(block,var,mode)

QTGlobals

dx2 = block.dx/2;
dy2 = block.dy/2;

x = block.x;
y = block.y;

[i1,i2,j1,j2] = GetQTKfctRange(x,y,dx2,dy2);

if mode == 'b'
        QTFct(i1:i2,j1:j2) = block.data(var);
elseif mode == 'i'

    grad = GetBlockGradient(block,var);
    
    for i =i1:i2
        dx = kQTxv(i)-block.x;
        for j = j1:j2
            dy = kQTyv(j)-block.y;
            QTFct(i,j) = block.data(var) + grad(1)*dx + grad(2)*dy;
        end
    end
elseif mode == 's'
     [sf,d,v] = GetBlockVsurface(block,var);
     lsf = sf(kQTxm(i1:i2,j1:j2),kQTym(i1:i2,j1:j2));
     QTFct(i1:i2,j1:j2) = lsf;
     
%      surface(kQTxv(i1:i2),kQTyv(j1:j2),lsf')
%      hold on
%      plot(d(:,1),d(:,2),'o');
end

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
    end
end

if ~block.br(RIGHT)
    
    x(end+1) = block.x + block.dx/2;
    y(end+1) = block.y;
    
    if isnan(block.bc(RIGHT)) % floating
        v(end+1) = block.data(var);
    else
        v(end+1) = block.bcs;
    end
    
    if ~block.br(UP)
        x(end+1) = block.x + block.dx/2;
        y(end+1) = block.y + block.dx/2;
    
        if isnan(block.bc(RIGHT)) % floating
            v(end+1) = block.data(var);
        else
            v(end+1) = block.bcs;
        end
        
    end
    
end

[d,c] = unique([x',y'],'rows');
v = v(c);

sf = fit(d,v','cubicinterp');

end
function grad = GetBlockGradient(block,var)

QTGlobals

x(1) = block.x;
xv(1) = block.data(var);

y(1) = block.y;
yv(1) = block.data(var);

if block.br(LEFT)
    x(end+1) = Blocks{block.br(LEFT)}.x;
    if block.br(LEFT_MIN)
        xv(end+1) = (Blocks{block.br(LEFT_MIN)}.data(var)+Blocks{block.br(LEFT)}.data(var))*0.5;
    else
        xv(end+1) = Blocks{block.br(LEFT)}.data(var);
    end
end

if block.br(RIGHT)
    x(end+1) = Blocks{block.br(RIGHT)}.x;
    if block.br(RIGHT_MIN)
        xv(end+1) = (Blocks{block.br(RIGHT_MIN)}.data(var)+Blocks{block.br(RIGHT)}.data(var))*0.5;
    else
        xv(end+1) = Blocks{block.br(RIGHT)}.data(var);
    end
end

if block.br(UP)
    y(end+1) = Blocks{block.br(UP)}.y;
    if block.br(UP_MIN)
        yv(end+1) = (Blocks{block.br(UP_MIN)}.data(var)+Blocks{block.br(UP)}.data(var))*0.5;
    else
        yv(end+1) = Blocks{block.br(UP)}.data(var);
    end
end

if block.br(DOWN)
    y(end+1) = Blocks{block.br(DOWN)}.y;
    if block.br(DOWN_MIN)
        yv(end+1) = (Blocks{block.br(DOWN_MIN)}.data(var)+Blocks{block.br(DOWN)}.data(var))*0.5;
    else
        yv(end+1) = Blocks{block.br(DOWN)}.data(var);
    end
end

lxv = length(xv);
lyv = length(yv);

x = x - block.x;
y = y - block.y;

if lxv > 2
    polyx = polyfit(x,xv,2);
    gradx = polyx(1)*x(1) + polyx(2);
elseif lxv == 2
    polyx = polyfit(x,xv,1);
    gradx = polyx(1);
else 
    gradx = 0;
end

if lyv > 2
    polyy = polyfit(y,yv,2);
    grady = polyy(1)*y(1) + polyy(2);
elseif lyv == 2
    polyy = polyfit(y,yv,1);
    grady = polyy(1);
else
    grady = 0;
end

grad = [gradx grady];


end