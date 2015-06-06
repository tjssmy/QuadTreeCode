function [IntBC] = SetQTTransBVec(IntBC,t)

QTGlobals

for i=1:length(IntBC)
    if IntBC(i).trans
        for j=1:length(IntBC(i).blocks)
            b = IntBC(i).blocks(j);
           SetQTBTransVecBlock(Blocks{b},IntBC(i),t);
        end
    end
end
end

function SetQTBTransVecBlock(block,IntBC,t)

QTGlobals

n = block.k;

if IntBC.mode == 'v'
    QTBVec(n) = QTTransFct(IntBCVal.TransMode(1),IntBC.valTrans{1},t);
    return
elseif IntBC.mode == 'g'
    v = QTTransFct(IntBCVal.TransMode(1),IntBC.valTrans{1},t);
    g = QTTransFct(IntBCVal.TransMode(2),IntBC.valTrans{2},t);
    QTBVec(n) = -v*g;
elseif IntBC.mode == 'm'
    v = QTTransFct(IntBC.TransMode(1),IntBC.valTrans{1},t);
    g = QTTransFct(IntBC.TransMode(2),IntBC.valTrans{2},t);
    f = QTTransFct(IntBC.TransMode(3),IntBC.valTrans{3},t);
    QTBVec(n) = -v*g + f;
end

end