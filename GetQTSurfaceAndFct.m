function [surf] = GetQTSurfaceAndFct(var,drawfig,tle)
QTGlobals

surf = CreateQTVarSurf(var);
QTFct = surf(kQTxm,kQTym);

if drawfig
    figure
    surface(kQTxv,kQTyv,QTFct','EdgeColor','none');
    title(tle);
end

% GetQTFct(var,'s',drawfig,tle);

end