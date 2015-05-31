function GetQTFct(var,interp)

QTGlobals

for b=1:nBlocks
    SetQTFctBlock(Blocks{b},var,interp);
end

end

function SetQTFctBlock(block,var,interp)

QTGlobals

dx2 = block.dx/2;
dy2 = block.dy/2;

x = block.x;
y = block.y;

[i1,i2,j1,j2] = GetQTKfctRange(x,y,dx2,dy2);

if ~interp
        QTFct(i1:i2,j1:j2) = block.data(var);
else

    grad = GetBlockGradient(block,var);
    
    for i =i1:i2
        dx = kQTxv(i)-block.x;
        for j = j1:j2
            dy = kQTyv(j)-block.y;
            QTFct(i,j) = block.data(var) + grad(1)*dx + grad(2)*dy;
        end
    end
    
end

end

function grad = GetBlockGradient(block,var)

QTGlobals

x(2) = block.x;
xv(2) = block.data(var);

y(2) = block.y;
yv(2) = block.data(var);

for br=1:MAX_NUM_BR
    if block.br(br)
        
        if br == LEFT
            x(1) = Blocks{block.br(br)}.x;
            xv(1) = Blocks{block.br(br)}.data(var);
        elseif br == LEFT_MIN
            xv(1) = (xv(1) + Blocks{block.br(br)}.data(var))*0.5;
        elseif br == RIGHT
            x(3) = Blocks{block.br(br)}.x;
            xv(3) = Blocks{block.br(br)}.data(var);
        elseif br == RIGHT_MIN
            xv(3) = (xv(3) + Blocks{block.br(br)}.data(var))*0.5;
        elseif br == DOWN
            y(1) = Blocks{block.br(br)}.y;
            yv(1) = Blocks{block.br(br)}.data(var);
        elseif br == DOWN_MIN
            yv(1) = (yv(1) + Blocks{block.br(br)}.data(var))*0.5;
        elseif br == UP
            y(3) = Blocks{block.br(br)}.y;
            yv(3) = Blocks{block.br(br)}.data(var);
        elseif br == DOWN_MIN
            yv(3) = (yv(3) + Blocks{block.br(br)}.data(var))*0.5;
        end
    end
end

lxv = length(xv);
lyv = length(yv);


if lxv > 2
    polyx = polyfit(x,xv,2);
    gradx = polyx(2);
elseif lxv == 2
    polyx = polyfit(x,xv,1);
    gradx = polyx(1);
else 
    gradx = 0;
end

if lyv > 2
    polyy = polyfit(y,yv,2);
    grady = polyy(2);
elseif lyv == 2
    polyy = polyfit(y,yv,1);
    grady = polyy(1);
else
    grady = 0;
end

grad = [gradx grady];

end