function CreateInitQTBlocks(nx,ny,drawfig)
%CREATEINITBLOCKS -- initial uniform block creation
QTGlobals

fprintf('Creating initial blocks ...')
dx = QTXmax/nx;
dy = QTYmax/ny;

k = 1;
for j=1:ny

    y = (j-0.5)*dy;
    
    for i = 1:nx
        
        if j == 1
            kdown = 0;
        else
            kdown = k-nx;
        end
        
        if j == ny
            kup = 0;
        else
            kup = k+nx;
        end
        
        if i == 1
            kleft = 0;
        else
            kleft = k-1;
        end
        
        if i == nx
            kright = 0;
        else
            kright = k+1;
        end
        
        x = (i-0.5)*dx;
        
        Blocks{k} = CreateQTBlock(x,y,dx,dy,k,kup,kdown,kleft,kright);
        k = k+1;
    end
end

nBlocks = k-1;

if drawfig
    figure
    DrawQTBlocks(1,0,1,1,1)
    title('Initial blocks');
end

fprintf('\n');

end

