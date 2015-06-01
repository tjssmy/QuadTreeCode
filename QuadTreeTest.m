
QTGlobalsInit

kQTnx = 200;
kQTny = 300;

QTXmax = 200;
QTYmax = 300;

kQTdx = QTXmax/kQTnx;
kQTdy = QTYmax/kQTny;

kQTxv = linspace(0,QTXmax,kQTnx);
kQTyv = linspace(0,QTYmax,kQTny)';

kQTxm = repmat(kQTxv',1,kQTny);
kQTym = repmat(kQTyv',kQTnx,1);

kQTColormap = colormap;
kQTColormapSize = length(colormap);

figure;
axis([0 QTXmax 0 QTYmax]);

rng(3);
Alt = 0.1*ones(kQTnx,kQTny);
for i = 1:10
    xmm = kQTxm - rand()*QTXmax;
    ymm = kQTym - rand()*QTYmax;
    stdx = max((rand()*QTXmax*0.3)^2,0.2*QTXmax);
    stdy = max((rand()*QTYmax*0.3)^2,0.2*QTYmax);
    
    Alt = Alt + rand(1)*exp(-(xmm.*xmm/stdx + ymm.*ymm/stdy));
    
    close
end

surface(kQTxv,kQTyv,Alt','EdgeColor','none')
title('Alt')

kQTFct = max(max(Alt))^2-Alt.*Alt-1;
kQTFct = max(0.01,kQTFct);
kQTFct = kQTFct/max(max(kQTFct));

% a = 2*pi/QTXmax;
% b = 3*pi/QTYmax;
% kQTFct = 0.5*sin(a*xm).*sin(b*ym)+0.5;
% kQTFct = max(kQTFct,0.1);

% kQTFct = ym/QTYmax;
% kQTFct = 0.5*ones(kQTnx,kQTny);


kQTMax = max(kQTFct);

QTFct = zeros(kQTnx,kQTny);

figure
axis([0 QTXmax 0 QTYmax]);
surface(kQTxv,kQTyv,kQTFct','EdgeColor','none');
title('k surface');

nxb = 2;
nyb = 3;

CreateInitQTBlocks(QTXmax,QTYmax,nxb,nyb);
figure
DrawQTBlocks(1,0,1,1,1)
title('Initial blocks');

RefineReg(1).geo = 'c';
RefineReg(1).x0 = 30;
RefineReg(1).y0 = 30;
RefineReg(1).rad = 20;
RefineReg(1).size = 1;

RefineReg(2).geo = 'c';
RefineReg(2).x0 = 170;
RefineReg(2).y0 = 260;
RefineReg(2).rad = 10;
RefineReg(2).size = 1;

CreateQTSmap(RefineReg);

RefineQTBlocks(5,0.1)

figure
DrawQTBlocks(1,0,1,1,0)
title('Refined blocks');

GetQTFct(KVAL,'b')
figure
surface(kQTxv,kQTyv,QTFct','EdgeColor','none');
title('block k no interp');

GetQTFct(KVAL,'s')
figure
surface(kQTxv,kQTyv,QTFct','EdgeColor','none');
title('block k with interp');

QTGMat = sparse(nBlocks,nBlocks);
QTBVec = zeros(nBlocks,1);

% SetQTGMat(1,0,'f','f');
% SetQTBVec(1,0,'f','f',[]);

IntBC(1).geo = [ 10 40 10 40];
IntBC(1).val = 1;

IntBC(2).geo = [ 160 180 250 270 ];
IntBC(2).val = 0;

SetQTGMat('f','f','f','f');
SetQTBVec('f','f','f','f',IntBC);

% figure; 
% spy(QTGMat);

QTVvec = QTGMat\QTBVec;

UpdateQTBlockV(VVAL);
figure
GetQTFct(VVAL,'b')
surface(kQTxv,kQTyv,QTFct','EdgeColor','none');
title('Solution no interp');

figure
GetQTFct(VVAL,'s')
surface(kQTxv,kQTyv,QTFct','EdgeColor','none');
title('Solution with interp');

figure

[gx,gy] = gradient(QTFct);
fx = -gx.*kQTFct;
fy = -gy.*kQTFct;
flow = sqrt(fx.*fx+fy.*fy);
surface(kQTxv,kQTyv,flow','EdgeColor','none');
title('flow');
figure

quiver(kQTxv,kQTyv,fy',fx')
title('flow');