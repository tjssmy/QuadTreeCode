
QTGlobalsInit

kQTnx = 100;
kQTny = 150;

QTXmax = 200;
QTYmax = 300;

kQTdx = QTXmax/kQTnx;
kQTdy = QTYmax/kQTny;

figure(1);
axis([0 QTXmax 0 QTYmax]);
kQTColormap = colormap;
kQTColormapSize = length(colormap);

kQTxv = linspace(0,QTXmax,kQTnx);
kQTyv = linspace(0,QTYmax,kQTny)';

xm = repmat(kQTxv',1,kQTny);
ym = repmat(kQTyv',kQTnx,1);

a = 2*pi/QTXmax;
b = 3*pi/QTYmax;
kQTFct = 0.5*sin(a*xm).*sin(b*ym)+0.5;
% kQTFct = 0.5*ones(kQTnx,kQTny);

kQTFct = max(kQTFct,0.4);
kQTMax = max(kQTFct);

QTFct = zeros(kQTnx,kQTny);

surface(kQTxv,kQTyv,kQTFct','EdgeColor','none');

nxb = 2;
nyb = 3;

CreateInitQTBlocks(QTXmax,QTYmax,nxb,nyb);
figure(2)
DrawQTBlocks(1,0,1,1,1)

RefineQTBlocks(4,0.1)

figure(3)
DrawQTBlocks(1,0,0,1,0)

GetQTFct(KVAL,0)
figure(4)
surface(kQTxv,kQTyv,QTFct','EdgeColor','none');

GetQTFct(KVAL,1)
figure(5)
surface(kQTxv,kQTyv,QTFct','EdgeColor','none');


QTGMat = sparse(nBlocks,nBlocks);
SetQTGMat(1,0,'f','f');
figure; 
spy(QTGMat);

QTBVec = zeros(nBlocks,1);
SetQTBVec(1,0,'f','f');

QTVvec = QTGMat\QTBVec;

UpdateQTBlockV();
figure
GetQTFct(VVAL,1)
surface(kQTxv,kQTyv,QTFct','EdgeColor','none');


