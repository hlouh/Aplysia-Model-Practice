%These are all codes trying to reproduce the figures from Sutton et al 2004a
clear variables
%%
%Fig 5B
fs = 1e4; %frame size
disptm = 30; %number of seconds between displacements
maxdisp = 0.02; %2cm
dispstep = 0.0016; %1.6mm
t = 1; %each timestep is 1e-3 of a second
x(t) = 0;
while x(t) < maxdisp
    t=t+1;
    z = floor(t/(disptm*fs));
    x(t) = dispstep*z;
end
t = t-1;
x = x(1:t);
peak = x(end);
while t < 600*fs
    t = t+1;
    c = z-(floor(t/(disptm*fs))+1);
    x(t) = dispstep*c+peak;
end
% figure
% plot(1:1:length(x),x);
%%
%Calculating the spring and damping constants // this is a mistake!
%Retraction should follow immediately after protraction!
Parameters;
Y = 1;  %1 or 0 for protraction or retraction, respecitvely
if Y == 1
    [Kk,Km,Dm,Dk]=protraction(A1,A2,Dx,Xo,C1,C2,C3,E1,F1,F2,F3,x);
elseif Y == 0
    [Kk,Km,Dm,Dk]=retraction(B1,B2,B3,B4,D1,D2,E1,G1,G2,m,x);
else
    display('Please enter either 1 or 0 for Y');
end
%%
%Spring Equations
%The first element is removed after calculating dotx and dotm to keep the
%matrix dimensions consistent for calculating dotFm and Fm
dt = 1;
for i=1:(length(x)-1)
    dotx(i) = (x(i+1)-x(i))/dt; %change in position over 1 unit of time
    Fk(i) = Kk(i)*x(i)+Dk(i)*dotx(i);
%     Fk(i) = Kk(i)*x(i)+Dk(i)*0;
    dotKm(i) = (Km(i+1)-Km(i))/dt;
end
Dk(1)=[];
Dm(1)=[];
Kk(1)=[];
Km(1)=[];
intrv = [1,length(x)-1];
step = linspace(intrv(1),intrv(end),intrv(end));
Fm = zeros(1,length(x)-1);
dotFm = zeros(1,length(x)-1);
for w=2:(length(x)-1)
    dotFm(w-1) = Km(w-1)*(dotx(w-1)-Fm(w-1)/Dm(w-1));
%     dotFm(w-1) = dotKm(w-1)*Fm(w-1)/Km(w-1)+Km(w-1)*(dotx(w-1)-Fm(w-1)/Dm(w-1));
%     dotFm(w-1) = dotKm(w-1)*Fm(w-1)/Km(w-1)+Km(w-1)*(0-Fm(w-1)/Dm(w-1));
    if isnan(dotFm(w-1))== 1;
        dotFm(w-1)=0;
        Fm(w)=Fm(w-1)+dotFm(w-1)*dt;
    else
        Fm(w)=Fm(w-1)+dotFm(w-1)*dt;
    end
end
F = Fm+Fk;
% [t,Fm] = ode23(@(t,Fm)Fmfunc(t,Fm,dotKm,Km,dotx,Dm,step),step,0);
% F = Fm' + Fk;
figure
plot(step,F)
% plot(step,Fk)
% plot(step,Fm)
% plot(step,dotFm)
% plot(step,Km)
% plot(step,dotKm)
% plot(step,Dm)
plot(step,Kk)
% plot(step,Dk)
% plot(step,dotx)
%% Figure 9, starting at 3 seconds and onwards with just the Kelvin element
% tau = max(Dk)/max(Kk);
% cnst = max(Fk)/max(Kk);
% tt = linspace(1,4,100);
% xx = exp(-1.*tt./tau).*cnst.*(1-exp(-1.*tt./tau));
% figure
% plot(tt,xx)