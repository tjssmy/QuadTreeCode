function [ surf ] = CreateQTVarSurf( var)

QTGlobals

fprintf('Generating Surface (%i): \n',var);

x = zeros(1,nBlocks);
y = zeros(1,nBlocks);
v = zeros(1,nBlocks);

fprintf('\tBlocks ');
for b=1:nBlocks
    if mod(b,500) == 0, fprintf('... %i',b); end
     if mod(b,3500) == 0, fprintf('\n\t\t'); end
    x(b) = Blocks{b}.x;
    y(b) = Blocks{b}.y;
    v(b) = Blocks{b}.data(var);
    
end
fprintf('\n');

fprintf('\tBoundaries ');
for b=1:nBlocks
    if mod(b,500) == 0, fprintf('... %i',b); end
    if mod(b,3500) == 0, fprintf('\n\t\t'); end
    
    if  ~Blocks{b}.br(RIGHT) || ~Blocks{b}.br(LEFT) || ...
            ~Blocks{b}.br(DOWN) ||~Blocks{b}.br(UP)
        [x,y,v] = AddQTBlockSurfacePnts(Blocks{b},x,y,v,var);
    end
    
end

fprintf('\n\tGenerating Surface');
[d,c] = unique([x',y'],'rows');
v = v(c);

surf = fit(d,v','cubicinterp');

fprintf('... done\n');
end

