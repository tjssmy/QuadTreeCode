function UpdateQTBlockV(var)

QTGlobals 

for b=1:nBlocks
    Blocks{b}.data(var) = QTVvec(b);
end