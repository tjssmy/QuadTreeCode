function [IntBC] = SolveQTVar(BC,IntBC)

QTGlobals

SetQTGMat(BC(1),BC(2),BC(3),BC(4));
IntBC = SetQTBVec(BC(1),BC(2),BC(3),BC(4),IntBC);

QTVvec = QTGMat\QTBVec;

UpdateQTBlockV(VVAL);

end