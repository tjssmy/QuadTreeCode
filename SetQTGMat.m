function SetQTGMat(LeftBC,RightBC,UpBC,DownBC)

QTGlobals

for b=1:nBlocks
    SetQTGMatBlock(Blocks{b},RightBC,LeftBC,UpBC,DownBC);
end

end

function SetQTGMatBlock(block,RightBC,LeftBC,UpBC,DownBC)

QTGlobals

dx = block.dx;
dy = block.dy;
k1 = block.data(KVAL);
n = block.k;

Gtot = 0;

for br = 1:MAX_NUM_BR
    m = block.br(br);
    if m
        k2 = Blocks{block.br(br)}.data(KVAL);
        dx2 = Blocks{block.br(br)}.dx;
        dy2 = Blocks{block.br(br)}.dy;
        
        if br <= RIGHT_MIN % left/right
            l1 = dx*0.5;     w1 = dy;
            l2 = dx2*0.5;    w2 = dy2;
        else
            l1 = dy*0.5;     w1 = dx;
            l2 = dy2*0.5;    w2 = dx2;
            
        end

        r = 1/k1*l1/w1 + 1/k2*l2/w2;

        if r ~= 0
            gval = 1/r;
            Gtot = Gtot + gval;
        end
        
        QTGMat(n,m) = QTGMat(n,m) + gval;

    else
        if br == RIGHT && RightBC ~= 'f'
            l1 = dx*0.5; w1 = dy; r = 1/k1*l1/w1;
        elseif br == LEFT && LeftBC ~= 'f'
            l1 = dx*0.5; w1 = dy; r = 1/k1*l1/w1;
        elseif br == UP && UpBC ~= 'f'
            l1 = dy*0.5; w1 = dx; r = 1/k1*l1/w1;
        elseif br == DOWN && DownBC ~= 'f'
            l1 = dy*0.5; w1 = dx; r = 1/k1*l1/w1;
        else
            r = 0;
        end
        
        if r~= 0
            gval = 1/r;
            Gtot = Gtot + gval;
        end
    end
end

QTGMat(n,n) = QTGMat(n,n) - Gtot;

end