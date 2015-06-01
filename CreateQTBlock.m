function [ block ] = CreateQTBlock(x,y,dx,dy,k,kup,kdown,kleft,kright)

QTGlobals

block.k = k;
block.dx = dx;
block.dy = dy;
block.x = x;
block.y = y;
block.br(LEFT) = kleft;
block.br(RIGHT) = kright;
block.br(DOWN) = kdown;
block.br(UP) = kup;
block.bc(1:MAX_NUM_BR) = NaN;

[i1,i2,j1,j2] = GetQTKfctRange(x,y,dx/2,dy/2);

kMap = kQTFct(i1:i2,j1:j2);

meanK = mean(mean(kMap));


block.data(KVAL) = meanK;
block.data(VVAL) = 0;

block.br(MAX_NUM_BR) = 0;

block.size = 1;
end

