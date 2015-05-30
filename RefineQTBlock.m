function RefineQTBlock(b,kThresh)
QTGlobals 

block = Blocks{b};

dx2 = block.dx/2;
dy2 = block.dy/2;

x = block.x;
y = block.y;

x1 = x - dx2;
x2 = x + dx2;
y1 = y - dy2;
y2 = y + dy2;

i1 = max(1,floor(x1/kQTdx));
i2 = min(kQTnx,ceil(x2/kQTdx));

j1 = max(1,floor(y1/kQTdy));
j2 = min(kQTny,ceil(y2/kQTdy));


kMap = kQTFct(i1:i2,j1:j2);

maxK = max(max(kMap));
minK = min(min(kMap));

delK = maxK-minK;

if (delK > kThresh) % needs to be broken into 4
    CutQTBlock(b);
end

end

function CutQTBlock(b)

QTGlobals

block = Blocks{b};

dx2 = block.dx/2;
dy2 = block.dy/2;

x = block.x;
y = block.y;

if (block.br(LEFT) && Blocks{block.br(LEFT)}.size > block.size)
    CutQTBlock(block.br(LEFT));
end

if (block.br(RIGHT) && Blocks{block.br(RIGHT)}.size > block.size)
    CutQTBlock(block.br(RIGHT));
end

if (block.br(UP) && Blocks{block.br(UP)}.size > block.size)
    CutQTBlock(block.br(UP));
end

if (block.br(DOWN) && Blocks{block.br(DOWN)}.size > block.size)
    CutQTBlock(block.br(DOWN));
end

block = Blocks{b}; % the cutting above might have changed the block data

k1 = block.k;
k2 = length(Blocks)+1;
k3 = k2+1;
k4 = k3+1;

kup = block.br(UP);
kup2 = block.br(UP_MIN);
if ~kup2
    kup2 = kup;
end

kdown = block.br(DOWN);
kdown2 = block.br(DOWN_MIN);
if ~kdown2
    kdown2 = kdown;
end

kright = block.br(RIGHT);
kright2 = block.br(RIGHT_MIN);
if ~kright2
    kright2 = kright;
end

kleft = block.br(LEFT);
kleft2 = block.br(LEFT_MIN);
if ~kleft2
    kleft2 = kleft;
end

block1 = CreateQTBlock(x-dx2/2,y-dy2/2,dx2,dy2,k1,k2,kdown2,kleft,k4);
block2 = CreateQTBlock(x-dx2/2,y+dy2/2,dx2,dy2,k2,kup,k1,kleft2,k3);
block3 = CreateQTBlock(x+dx2/2,y+dy2/2,dx2,dy2,k3,kup2,k4,k2,kright);
block4 = CreateQTBlock(x+dx2/2,y-dy2/2,dx2,dy2,k4,k3,kdown,k1,kright2);

block1.size = block.size/2;
block2.size = block.size/2;
block3.size = block.size/2;
block4.size = block.size/2;


if kleft 
    if kleft == kleft2
        Blocks{kleft}.br(RIGHT_UP) = k2;
        Blocks{kleft}.br(RIGHT_DOWN) = k1;
    else
        Blocks{kleft}.br(RIGHT) = k1;
        Blocks{kleft2}.br(RIGHT) = k2;
    end
end

if kright
    if kright == kright2
        Blocks{kright}.br(LEFT_UP) = k3;
        Blocks{kright}.br(LEFT_DOWN) = k4;
    else
        Blocks{kright}.br(LEFT) = k3;
        Blocks{kright2}.br(LEFT) = k4;
    end
end

if kup
    if kup == kup2
        Blocks{kup}.br(DOWN_LEFT) = k2;
        Blocks{kup}.br(DOWN_RIGHT) = k3;
    else
        Blocks{kup}.br(DOWN) = k2;
        Blocks{kup2}.br(DOWN) = k3;
    end
end

if kdown
    if kdown == kdown2
        Blocks{kdown}.br(UP_LEFT) = k1;
        Blocks{kdown}.br(UP_RIGHT) = k4;
    else
        Blocks{kdown2}.br(UP) = k1;
        Blocks{kdown}.br(UP) = k4;
    end
end

Blocks{k1} = block1;
Blocks{end+1} = block2;
Blocks{end+1} = block3;
Blocks{end+1} = block4;

nBlocks = nBlocks+3;

% EraseQTMesh
% DrawQTBlocks


% DrawQTBlock(block1);
% DrawQTBlock(block2);
% DrawQTBlock(block3);
% DrawQTBlock(block4);



end