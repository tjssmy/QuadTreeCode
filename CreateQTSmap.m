function CreateQTSmap(RefineReg)

QTGlobals

QTSmap = min(QTXmax,QTYmax)*ones(kQTnx,kQTny);

for r = 1:length(RefineReg)
    
    if RefineReg(r).geo == 'c'
        xshm = kQTxm - RefineReg(r).x0;
        yshm = kQTym - RefineReg(r).y0;
        
        rad = sqrt(xshm.*xshm + yshm.*yshm);
        ind = rad < RefineReg(r).rad;
        QTSmap(ind) = min(QTSmap(ind),RefineReg(r).size);
        
    elseif RefineReg(r).geo == 'r'
        
    end
end


end