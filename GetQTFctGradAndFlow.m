function GetQTFctGradAndFlow(drawfig,tle)

QTGlobals

[QTFctGx,QTFctGy] = gradient(QTFct);
QTFctFx = QTFctGx.*kQTFct;
QTFCTFy = QTFctGy.*kQTFct;
flow = sqrt(QTFctFx.*QTFctFx+QTFCTFy.*QTFCTFy);

if drawfig
    figure
    surface(kQTxv,kQTyv,flow','EdgeColor','none');
    title(['mag of ' tle]);
    
    figure
    quiver(kQTxv,kQTyv,QTFCTFy',QTFctFx')
    title(tle);
end

end