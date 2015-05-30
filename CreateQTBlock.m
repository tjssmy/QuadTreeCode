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

block.br(MAX_NUM_BR) = 0;

block.size = 1;
end

