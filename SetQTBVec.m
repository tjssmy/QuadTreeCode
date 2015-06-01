function SetQTBVec(LeftBC,RightBC,UpBC,DownBC,IntBC)

QTGlobals

for b=1:nBlocks
    SetQTBVecBlock(Blocks{b},RightBC,LeftBC,UpBC,DownBC,IntBC);
end

end

function SetQTBVecBlock(block,RightBC,LeftBC,UpBC,DownBC,IntBC)

QTGlobals

dx = block.dx;
dy = block.dy;
k1 = block.data(KVAL);
n = block.k;

if ~isempty(IntBC)
    for i = 1:length(IntBC)
        if block.x >= IntBC(i).geo(1) && block.x <= IntBC(i).geo(2) && ...
                block.y >= IntBC(i).geo(3) && block.y <= IntBC(i).geo(4)
            QTBVec(n) = IntBC(i).val;
            QTGMat(n,:) = 0;
            QTGMat(n,n) = 1;
            return
        end
    end
end

Ftot = 0;

for br = 1:MAX_NUM_BR
    m = block.br(br);
    
    if m == 0
        if br == RIGHT && RightBC ~= 'f'
            l1 = dx*0.5; w1 = dy; f = RightBC*(k1/l1*w1);
            block.bc(RIGHT) = RightBC;
        elseif br == LEFT && LeftBC ~= 'f'
            l1 = dx*0.5; w1 = dy; f = LeftBC*(k1/l1*w1);
            block.bc(LEFT) = LeftBC;
        elseif br == UP && UpBC ~= 'f'
            l1 = dy*0.5; w1 = dx; f = UpBC*(k1/l1*w1);
            block.bc(UP) = UpBC;
        elseif br == DOWN && DownBC ~= 'f'
            l1 = dy*0.5; w1 = dx; f = DownBC*(k1/l1*w1);
            block.bc(DOWN) = DownBC;
        else
            f = 0;
        end
        Ftot = Ftot + f;
    end
    
    end

QTBVec(n) = QTBVec(n) - Ftot;

end