function GetQTFct(var,mode,drawfig,tle)

QTGlobals

fprintf('Generating Block Surface Values (%s,%i) : ',mode,var);

for b=1:nBlocks
    
    if mod(b,500) == 0, fprintf('... %i',b); end
    if mod(b,3500) == 0, fprintf('\n\t\t'); end
    SetQTFctBlock(Blocks{b},var,mode);
end

fprintf('\n');

if drawfig
    figure
    surface(kQTxv,kQTyv,QTFct','EdgeColor','none');
    title(tle);
end

end

function SetQTFctBlock(block,var,mode)

QTGlobals

dx2 = block.dx/2;
dy2 = block.dy/2;

x = block.x;
y = block.y;

[i1,i2,j1,j2] = GetQTKfctRange(x,y,dx2,dy2);

if mode == 'b'
        QTFct(i1:i2,j1:j2) = block.data(var);
elseif mode == 's'  
    
     lsf = block.sf{var}(kQTxm(i1:i2,j1:j2),kQTym(i1:i2,j1:j2));
     
     if max(max(isnan(lsf)))
         oldQt = QTFct(i1:i2,j1:j2);
         nanlsf = isnan(lsf);
         lsf(nanlsf) = 0;
         lsf = lsf + oldQt.*nanlsf;
     end
%      
%          
%          surface(kQTxv(i1:i2),kQTyv(j1:j2),lsf')
%          hold on
%          plot(d(:,1),d(:,2),'o');
%          DrawQTBlock(block,0,1,0);
%        
%   

     
     QTFct(i1:i2,j1:j2) = lsf;
     
end

end


