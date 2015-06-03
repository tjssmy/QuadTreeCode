function CreateQTkFctRandHills(numhills,size,drawfig)

QTGlobals

fprintf('Random Hills')

rng(3);
Alt = 0.01*ones(kQTnx,kQTny);
for i = 1:numhills
    xmm = kQTxm - rand()*QTXmax;
    ymm = kQTym - rand()*QTYmax;
    stdx = max((rand()*QTXmax*size)^2,(0.1*QTXmax)^2);
    stdy = max((rand()*QTYmax*size)^2,(0.1*QTYmax)^2);
    
    Alt = Alt + rand(1)*exp(-(xmm.*xmm/stdx + ymm.*ymm/stdy));
end

if drawfig
    surface(kQTxv,kQTyv,Alt','EdgeColor','none')
    title('Alt')
end
galt = gradient(Alt);

kQTFct = max(max(abs(galt)))-abs(galt);
kQTFct = (kQTFct/max(max(kQTFct))-0.7)/0.3;
kQTFct = max(0.001,kQTFct);


end