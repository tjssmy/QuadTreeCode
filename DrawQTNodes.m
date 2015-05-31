function DrawQTNodes()

QTGlobals

x  = zeros(1,nBlocks);
y = zeros(1,nBlocks);

for b=1:nBlocks
    x(b) = Blocks{b}.x;
    y(b) = Blocks{b}.y;
end

scatter(x,y,'k+');

end