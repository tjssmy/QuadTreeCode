%
%  Fsup = alpha*P1
%  Fflow = (P2-P1)/R
%  Fdem = Fmax - beta*P2
% 
% if P is voltage and F is flow
%  GND -> alpha -> P1 -> Res -> P2 -> Fmax -> GND
%                                  -> Beta -> GND
% supply equation is resistor of cond alpha
% demand equation is parallel combination of resistor and current
% source


R = .0000005;
Beta = 10;
Alpha = 10;
FMax = 100;

G = [-(Alpha + 1/R), 1/R; 1/R, -(1/R + Beta)];
B = [0,-FMax];

P0 = FMax/(Alpha+Beta)

P = G\B'

fs = Alpha*P(1)
fd = FMax-Beta*P(2)
