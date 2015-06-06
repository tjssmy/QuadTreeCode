function SolveQTTransSol(SimTime,dt,dtOut,IntBCTrans)

QTGlobals

% dV/dt = GV + q

% Vn = Vo + dt*GVn + dt*q
%   (I-G*dt)Vn = Vo + dt*q
%    Vn =  (I-G*dt)\(Vo + dt*q)
  

% assumes a initial condition n QTVvec and L and U have been found

H = spdiags(ones(nBlocks,1),0,nBlocks,nBlocks)-QTGMat*dt;
[L,U] = lu(H);

Vo = QTVvec;

n = ceil(SimTime/dt);
for i = 1:n
    t = i*dt;
    SetQTTransBVec(InstBC,t);
    QTVvec = U\(L\(Vo - dt*QTBVec));
    
    Vo = QTVvec;
end

