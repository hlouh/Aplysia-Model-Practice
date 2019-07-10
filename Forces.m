% Define the passive forces as functions of displacement x and velocity v
% for the hinge model in the 2004 J Comp Phys paper by Sutton et al.

% Different rules for protraction (dx/dt>0) versus retraction (dx/dt<0) --
% but what if dx/dt=0?  Introduce an additional state variable: pro=1 if in
% protraction phase (even if dx/dt=0), ret=1 if in retraction phase, and
% nul=1 if truly neither protracting nor retracting (e.g. initial passive
% rest, before forces applied). 

% Units: x in meters, v=dx/dt in meters/sec.

global A1 A2 X0  B1 B2 B3 B4 Dx
global C1 C2 C3 D1 D2 E1 F1 F2 F3 G1 G2 
global Kk Km Dk Dm DKmDt Fk
global Kapp

Kapp=1000; % scales size of force applied by servomotor

Kk=@(x,pro,ret,nul)... % cf Table 1
    max(0,...
    pro.*(A2+(A1-A2)./(1+exp((x-X0)/Dx)))+...   % protraction
    ret.*(x>0.0091).*(B1+B2*x+B3*x.^2+B4*x.^3));         % retraction

Km=@(x,pro,ret,nul)... % cf Table 1
    max(0,...
    pro.*(C1+C2*x+C3*x.^2)+...                  % protraction
    ret.*(x>0.003).*(D1+D2*x));                  % retraction

Dk=E1; % cf Table 1

Dm=@(x,pro,ret,nul)... % cf Table 1
    pro.*(F1+F2*x+F3*x.^2)+...                   % protraction
    ret.*(G1+G2*x);                             % retraction

DKmDt=@(x,v,pro,ret,nul)... % cf equations in text near Table 1
    pro.*(C2+C3*x)+...
    ret.*(x>0.003).*(D2*v); % ignore delta function at x=0.003

Fk=@(x,v,pro,ret,nul)Kk(x,pro,ret,nul).*x+Dk.*v; 

