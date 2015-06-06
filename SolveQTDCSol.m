function [IntBC] = SolveQTDCSol(BC,IntBC)

QTGlobals

QTGMat = sparse(nBlocks,nBlocks);
QTBVec = zeros(nBlocks,1);

SetQTGMat(BC(1),BC(2),BC(3),BC(4));
IntBC = SetQTBVec(BC(1),BC(2),BC(3),BC(4),IntBC);

[QTGMatL,QTGMatU] = lu(QTGMat);

QTVvec = QTGMatU\(QTGMatL\QTBVec);

UpdateQTBlockV(VVAL);

end