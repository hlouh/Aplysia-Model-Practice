function dydt=hingeRHS(t,y)

% function dydt=hingeRHS(t,y)
%
% ODE right hand side for passive hinge model from Sutton et al 2004 J.
% Comp. Phys.
%

%global A1 A2 X0  B1 B2 B3 B4 C1 C2 C3 D1 D2 E1 F1 F2 F3 G1 G2 m
%global Kk Km Dk Dm DKmDt Fk
% use only what's needed
global m Km Dm DKmDt Fk dx Kapp

x=y(1)/100; % this is the displacement, in m
v=y(2)/100; % this is the velocity, in m/sec
Fm=y(3)/1000; % this is the Maxwell component of the force, in Newtons
%pro=y(4); % =1 iff we are protracting
%ret=y(5); % =1 iff we are retracting
%nul=y(6); % =1 iff we are neither protracting nor retracting

% put in switch between null, protraction, retraction by hand here:
pro=(t>=30).*(t<=390);
ret=(t>390);
nul=(t<30);

% calculate servomotor force.  Convert displacement from cm to m.
%Fapp=(xtarget(t,dx)/100-x)*Kapp;

dxdt=(xtarget(t,dx)/100 - x)*Kapp;
disp([xtarget(t,dx),x,dxdt])
%dvdt=(1/(1000*m))*(Fk(x,v,pro,ret,nul)+Fm+Fapp); % convert mass to grams
dvdt=NaN;
dFmdt=DKmDt(x,v,pro,ret,nul)*Fm/Km(x,pro,ret,nul)+...
    Km(x,pro,ret,nul)*(v-Fm/Dm(x,pro,ret,nul));
dprodt=0;
dretdt=0;
dnuldt=0;

if isnan(dFmdt)
    dFmdt=0; 
end

dydt=[dxdt;dvdt;dFmdt;dprodt;dretdt;dnuldt];

%keyboard

end

