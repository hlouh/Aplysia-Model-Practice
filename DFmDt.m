function dydt = DFmDt(t,y,x,v,pro,ret,nul,jump)
%Differential Equation for the Maxwell Element over Timesteps

% global A1 A2 X0  B1 B2 B3 B4 Dx
% global C1 C2 C3 D1 D2 E1 F1 F2 F3 G1 G2 
global Km Dm DKmDt %Fk Dk Kk 
% global Kapp

Fm=y;
% DKmDt(x,v,pro,ret,nul)*Fm./Km(x,pro,ret,nul)+
if jump==0
    dydt = Km(x,pro,ret,nul).*(v-Fm./Dm(x,pro,ret,nul));
elseif jump==1
    dydt = Km(x,pro,ret,nul).*v;
end
end