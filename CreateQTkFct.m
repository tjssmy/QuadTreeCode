function CreateQTkFct(nx,ny,xmax,ymax,type,para,drawfig)

QTGlobals

fprintf('Generating kMap:  ');

DefineQTkSpace(nx,ny,xmax,ymax);

if type == 'r'
    CreateQTkFctRandHills(para(1),para(2),para(3));
end

kQTMax = max(kQTFct);
QTFct = zeros(kQTnx,kQTny);

if drawfig
    figure
    surface(kQTxv,kQTyv,kQTFct','EdgeColor','none');
    title('k surface');
end

fprintf('\n');

end