function IntBC = QTCirIntBC(x0,y0,rad,val,mode)
IntBC.geo = 'c'; 
IntBC.gp = [x0,y0,rad];      
IntBC.val = val;
IntBC.mode = mode;
IntBC.blocks = [];
IntBC.trans = 0;
end