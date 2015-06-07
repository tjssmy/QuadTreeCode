function SolveQTTransSol(SimTime,nt,ntOut,IntBC)

QTGlobals

% dV/dt = GV + B(t)

% Vn = Vo + dt*GVn + dt*B(t)
%   (I-G*dt)Vn = Vo + dt*B(t)
%    Vn =  inv(I-G*dt)(Vo + dt*B(t)) = inv(H)(Vo + dt*B(t)) 
  

% assumes a initial condition n QTVvec and L and U have been found

[~,h] = GetQTSurfaceAndFct(VVAL,3,1,'Solution with interp',[]);
dt = SimTime/nt;

H = spdiags(ones(nBlocks,1),0,nBlocks,nBlocks)-QTGMat*dt;
[L,U] = lu(H);

Vo = QTVvec;


for i = 1:nt
    t = i*dt;
    
    SetQTTransBVec(IntBC,t);
    QTVvec = U\(L\(Vo - dt*QTBVec));
    UpdateQTBlockV(VVAL);

    Vo = QTVvec;
    if mod(i,ntOut) == 0
        display(['t' num2str(t)])
        [~,h] = GetQTSurfaceAndFct(VVAL,3,0,'Solution with interp',h);
        pause(0.01)
    end
end

