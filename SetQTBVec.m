function [IntBC] = SetQTBVec(LeftBC,RightBC,UpBC,DownBC,IntBC)

QTGlobals

for b=1:nBlocks
    IntBC = SetQTBVecBlock(Blocks{b},RightBC,LeftBC,UpBC,DownBC,IntBC);
end

end

function [IntBC] = SetQTBVecBlock(block,RightBC,LeftBC,UpBC,DownBC,IntBC)

QTGlobals

dx = block.dx;
dy = block.dy;
k1 = block.data(KVAL);
n = block.k;


if ~isempty(IntBC)
    for i = 1:length(IntBC)
        found = 0;
        if IntBC(i).geo == 'r'
            if block.x >= IntBC(i).gp(1) && block.x <= IntBC(i).gp(2) && ...
                    block.y >= IntBC(i).gp(3) && block.y <= IntBC(i).gp(4)
                found = 1;
            end
        elseif IntBC(i).geo == 'c'
            dx = block.x-IntBC(i).gp(1);
            dy = block.y-IntBC(i).gp(2);
            if  dx^2 + dy^2 < IntBC(i).gp(3)^2
                found = 1;
            end
        end
        
        if found
            
            IntBC(i).blocks(end+1) = n;
            
            if IntBC(i).mode == 'v'
                QTBVec(n) = IntBC(i).val(1);
                QTGMat(n,:) = 0;
                QTGMat(n,n) = 1;
                return
            elseif IntBC(i).mode == 'g'
                QTGMat(n,n) = QTGMat(n,n) - IntBC(i).val(2);
                QTBVec(n) = -IntBC(i).val(1)*IntBC(i).val(2);
            elseif IntBC(i).mode == 'm'
                QTGMat(n,n) = QTGMat(n,n) - IntBC(i).val(2);
                QTBVec(n) = -IntBC(i).val(1)*IntBC(i).val(2) + IntBC(i).val(3);
            end
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