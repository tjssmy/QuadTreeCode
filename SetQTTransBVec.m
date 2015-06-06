function [IntBC] = SetQTTransBVec(IntBC,t)

QTGlobals

for i=1:length(IntBC)
    for j=1:length(IntBC.blocks)
        b = IntBC.blocks(j);
        IntBC = SetQTBTransVecBlock(Blocks{b},IntBC,t);
    end
end
end

function [IntBC] = SetQTBTransVecBlock(block,IntBC)

QTGlobals

n = block.k;

if IntBC.mode == 'v'
    QTBVec(n) = QTTransFct(IntBCVal.TransMode(1),IntBC.valTrans(1,:),t);
    return
elseif IntBC.mode == 'g'
    v = QTTransFct(IntBCVal.TransMode(1),IntBC.valTrans(1,:),t);
    g = QTTransFct(IntBCVal.TransMode(2),IntBC.valTrans(2,:),t);
    QTBVec(n) = -v*g;
elseif IntBC.mode == 'm'
    v = QTTransFct(IntBCVal.TransMode(1),IntBC.valTrans(1,:),t);
    g = QTTransFct(IntBCVal.TransMode(2),IntBC.valTrans(2,:),t);
    f = QTTransFct(IntBCVal.TransMode(3),IntBC.valTrans(3,:),t);
    QTBVec(n) = -v*g + f;
end

end