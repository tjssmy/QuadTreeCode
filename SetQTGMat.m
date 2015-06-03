function SetQTGMat(LeftBC,RightBC,UpBC,DownBC)

QTGlobals

for b=1:nBlocks
    SetQTGMatBlock(b,RightBC,LeftBC,UpBC,DownBC);
end

end

function SetQTGMatBlock(b,RightBC,LeftBC,UpBC,DownBC)

QTGlobals

dx = Blocks{b}.dx;
dy = Blocks{b}.dy;
k1 = Blocks{b}.data(KVAL);
n = Blocks{b}.k;

Gtot = 0;

for br = 1:MAX_NUM_BR
    m = Blocks{b}.br(br);
    if m
        k2 = Blocks{Blocks{b}.br(br)}.data(KVAL);
        dx2 = Blocks{Blocks{b}.br(br)}.dx;
        dy2 = Blocks{Blocks{b}.br(br)}.dy;
        
        if br <= RIGHT_MIN % left/right
            l1 = dx*0.5;     w1 = dy;
            l2 = dx2*0.5;    w2 = dy2;
        else
            l1 = dy*0.5;     w1 = dx;
            l2 = dy2*0.5;    w2 = dx2;
            
        end

        r = 1/k1*l1/w1 + 1/k2*l2/w2;
        Blocks{b}.res(br) = r;
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
        
        Blocks{b}.res(br) = r;
        
        if r~= 0
            gval = 1/r;
            Gtot = Gtot + gval;
        end
    end
end

QTGMat(n,n) = QTGMat(n,n) - Gtot;

end