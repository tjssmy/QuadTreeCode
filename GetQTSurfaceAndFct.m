function [surf h] = GetQTSurfaceAndFct(var,drawfig,newfig,tle,h)
QTGlobals

surf = CreateQTVarSurf(var);
QTFct = surf(kQTxm,kQTym);

if drawfig
    if newfig, figure; end
    if ~isempty(h), delete(h); end
    
    subplot(1,drawfig,1), h(1) = surface(kQTxv,kQTyv,QTFct','EdgeColor','none');
    title(tle);
    
    if drawfig >= 2
        
        [QTFctGx,QTFctGy] = gradient(QTFct);
        QTFctFx = QTFctGx.*kQTFct;
        QTFCTFy = QTFctGy.*kQTFct;
        flow = sqrt(QTFctFx.*QTFctFx+QTFCTFy.*QTFCTFy);
        subplot(1,drawfig,2), h(2) = surface(kQTxv,kQTyv,flow','EdgeColor','none');

        if drawfig == 3            
            subplot(1,drawfig,3), h(3) = quiver(kQTxv,kQTyv,QTFCTFy',QTFctFx');
            axis([0,QTXmax,0,QTYmax]);
        end
    end
end

% GetQTFct(var,'s',drawfig,tle);

end