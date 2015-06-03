function RefineQTblocks(b,kThresh)
QTGlobals 

block = Blocks{b};

dx2 = block.dx/2;
dy2 = block.dy/2;

x = block.x;
y = block.y;

[i1,i2,j1,j2] = GetQTKfctRange(x,y,dx2,dy2);

kMap = kQTFct(i1:i2,j1:j2);


maxK = max(max(kMap));
minK = min(min(kMap));

delK = maxK-minK;

sVal = min(min(QTSmap(i1:i2,j1:j2)));

if (delK > kThresh || ...
        block.dx > sVal || block.dy > sVal) % needs to be broken into 4
    CutQTblocks(b);
end

end

function CutQTblocks(b)

QTGlobals

block = Blocks{b};

dx2 = block.dx/2;
dy2 = block.dy/2;

x = block.x;
y = block.y;

if (block.br(LEFT) && Blocks{block.br(LEFT)}.size > block.size)
    CutQTblocks(block.br(LEFT));
end

if (block.br(RIGHT) && Blocks{block.br(RIGHT)}.size > block.size)
    CutQTblocks(block.br(RIGHT));
end

if (block.br(UP) && Blocks{block.br(UP)}.size > block.size)
    CutQTblocks(block.br(UP));
end

if (block.br(DOWN) && Blocks{block.br(DOWN)}.size > block.size)
    CutQTblocks(block.br(DOWN));
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

blocks(1) = CreateQTBlock(x-dx2/2,y-dy2/2,dx2,dy2,k1,k2,kdown2,kleft,k4);
blocks(2) = CreateQTBlock(x-dx2/2,y+dy2/2,dx2,dy2,k2,kup,k1,kleft2,k3);
blocks(3) = CreateQTBlock(x+dx2/2,y+dy2/2,dx2,dy2,k3,kup2,k4,k2,kright);
blocks(4) = CreateQTBlock(x+dx2/2,y-dy2/2,dx2,dy2,k4,k3,kdown,k1,kright2);

blocks(1).size = block.size/2;
blocks(2).size = block.size/2;
blocks(3).size = block.size/2;
blocks(4).size = block.size/2;


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

for b = 1:4
    
    [i1,i2,j1,j2] = GetQTKfctRange(blocks(b).x,blocks(b).y,blocks(b).dx/2,blocks(b).dy/2);
    
    if ~blocks(b).br(RIGHT), blocks(b).bc(RIGHT,KVAL) = kQTFct(i2,round((j1+j2)/2)); end
    if ~blocks(b).br(LEFT), blocks(b).bc(LEFT,KVAL) = kQTFct(i1,round((j1+j2)/2)); end
    if ~blocks(b).br(UP)
        blocks(b).bc(UP,KVAL) = kQTFct(round((i1+i2)/2),j2); end
    if ~blocks(b).br(DOWN)
        blocks(b).bc(DOWN,KVAL) = kQTFct(round((i1+i2)/2),j1); end
end

Blocks{k1} = blocks(1);
Blocks{end+1} = blocks(2);
Blocks{end+1} = blocks(3);
Blocks{end+1} = blocks(4);

nBlocks = nBlocks+3;


% EraseQTMesh
% DrawQTBlocks


% DrawQTblocks(blocks(1));
% DrawQTblocks(blocks(2));
% DrawQTblocks(blocks(3));
% DrawQTblocks(blocks(4));



end