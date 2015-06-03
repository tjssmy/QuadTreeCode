function DefineQTkSpace(nx,ny,xmax,ymax)

QTGlobals

kQTnx = nx;
kQTny = ny;

QTXmax = xmax;
QTYmax = ymax;

kQTdx = QTXmax/kQTnx;
kQTdy = QTYmax/kQTny;

kQTxv = linspace(0,QTXmax,kQTnx);
kQTyv = linspace(0,QTYmax,kQTny)';

kQTxm = repmat(kQTxv',1,kQTny);
kQTym = repmat(kQTyv',kQTnx,1);

kQTColormap = colormap;
kQTColormapSize = length(colormap);

end