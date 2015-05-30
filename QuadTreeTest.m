
QTGlobalsInit

kQTnx = 100;
kQTny = 150;
Xmax = 200;
Ymax = 300;
kQTdx = Xmax/kQTnx;
kQTdy = Ymax/kQTny;

xv = linspace(0,Xmax,kQTnx);
yv = linspace(0,Ymax,kQTny)';

xm = repmat(xv',1,kQTny);
ym = repmat(yv',kQTnx,1);

a = 2*pi/Xmax;
b = 3*pi/Ymax;
kQTFct = sin(a*xm).*sin(b*ym);
kQTFct = max(kQTFct,0);
surface(xv,yv,kQTFct','EdgeColor','none');

nxb = 4;
nyb = 6;

CreateInitQTBlocks(Xmax,Ymax,nxb,nyb);

DrawQTBlocks(1)

RefineQTBlocks(6,0.1)

DrawQTBlocks(0)