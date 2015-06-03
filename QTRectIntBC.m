function IntBC = QTRectIntBC(x0,y0,x1,y1,val,mode)
IntBC.geo = 'r'; 
IntBC.gp = [x0,y0,x1,y1];      
IntBC.val = val;
IntBC.mode = mode;
IntBC.blocks = [];
end