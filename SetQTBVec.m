function SetQTBVec(LeftBC,RightBC,UpBC,DownBC)

QTGlobals

for b=1:nBlocks
    SetQTBVecBlock(Blocks{b},RightBC,LeftBC,UpBC,DownBC);
end

end

function SetQTBVecBlock(block,RightBC,LeftBC,UpBC,DownBC)

QTGlobals

dx = block.dx;
dy = block.dy;
k1 = block.data(KVAL);
n = block.k;

Ftot = 0;

for br = 1:MAX_NUM_BR
    m = block.br(br);
    
    if m == 0
        if br == RIGHT && RightBC ~= 'f'
            l1 = dx*0.5; w1 = dy; f = RightBC*(k1/l1*w1);
        elseif br == LEFT && LeftBC ~= 'f'
            l1 = dx*0.5; w1 = dy; f = LeftBC*(k1/l1*w1);
        elseif br == UP && UpBC ~= 'f'
            l1 = dy*0.5; w1 = dx; f = UpBC*(k1/l1*w1);
        elseif br == DOWN && DownBC ~= 'f'
            l1 = dy*0.5; w1 = dx; f = DownBC*(k1/l1*w1);
        else
            f = 0;
        end
        Ftot = Ftot + f;
    end
end

QTBVec(n) = QTBVec(n) - Ftot;

end