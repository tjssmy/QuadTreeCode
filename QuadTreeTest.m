
QTGlobalsInit

CreateQTkFct(300,200,200.0,300.0,'r',[10,0.3,1],0)
CreateInitQTBlocks(2,3,0);

RefineReg(1) = QTCirRefineReg(30,30,20,1);
RefineReg(2) = QTCirRefineReg(170,260,10,1);
RefineReg(3) = QTCirRefineReg(30,275,10,1);

CreateQTSmap(RefineReg);
RefineQTBlocks(6,0.1)

figure; DrawQTBlocks(1,0,1,1,0); title('Refined blocks');

% GetQTFct(KVAL,'b',1,'block k no interp')
GetQTSurfaceAndFct(KVAL,1,'block k with interp');


QTGMat = sparse(nBlocks,nBlocks);
QTBVec = zeros(nBlocks,1);

% IntBC(1) = QTRectIntBC(10,40,10,40,1);
% IntBC(2) = QTRectIntBC(160,180,250,270,0);

IntBC(1) = QTCirIntBC(20,20,10,[0 1e3],'g');
IntBC(end+1) = QTCirIntBC(170,260,10,[0 8e3 -1000],'m');
IntBC(end+1) = QTCirIntBC(30,275,10,[0 8e3 -1000],'m');
% IntBC(end+1) = QTCirIntBC(52,148,5,[0 1e3 -100],'m');


IntBC = SolveQTVar(['f','f','f','f'],IntBC);

% GetQTFct(VVAL,'b',1,'Solution no interp')
GetQTSurfaceAndFct(VVAL,1,'Solution with interp');


GetQTFctGradAndFlow(1,'flow');

PrintQTIntBCVals(IntBC)
