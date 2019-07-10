% script SuttonEtAl2004JCompPhysFig5.m

cd('/Users/pjthomas/github/hlouh/Aplysia-Model-Practice')
Parameters % load in parameters from Table I of paper
Forces % finishing loading definitions from Table I of paper.

global dx % step displacement size

%% check: view the terms

% xplot=linspace(-.02,0.02,201);
% 
% figure
% plot(xplot,Kk(xplot,1,0,0))
% hold on
% plot(xplot,Kk(xplot,0,1,0))
% xlabel('Position (m)','FontSize',20)
% ylabel('K_k','FontSize',20)
% set(gca,'FontSize',20)
% grid on
% legend('Protr.','Retr.')
% 
% figure
% plot(xplot,Km(xplot,1,0,0))
% hold on
% plot(xplot,Km(xplot,0,1,0))
% xlabel('Position','FontSize',20)
% ylabel('K_m','FontSize',20)
% set(gca,'FontSize',20)
% grid on
% legend('Protr.','Retr.')
% 
% figure
% plot(xplot,Dm(xplot,1,0,0))
% hold on
% plot(xplot,Dm(xplot,0,1,0))
% xlabel('Position','FontSize',20)
% ylabel('D_m','FontSize',20)
% set(gca,'FontSize',20)
% grid on
% legend('Protr.','Retr.')

%% Set step displacement pattern

tmin=0; % seconds
tmax=600; % seconds
tspan=linspace(tmin,tmax,20*100+1); % 20 stairsteps, 100 points each
dx=0.16; % cm
xtargetplot=xtarget(tspan,dx);

figure
subplot(3,1,3)
plot(tspan,xtargetplot,'LineWidth',3)
xlabel('Time (sec)')
ylabel('Disp. (cm)')
set(gca,'FontSize',20)

%%  Initialize

xinit=0.001; % m
vinit=0; % cm/sec
Fminit=0; % mN
pro=0; % initially we will be neither protracting nor retracting
ret=0;
nul=1;

y0=[xinit;vinit;Fminit;pro;ret;nul];

%% Run

[t,y]=ode15s(@hingeRHS,tspan,y0);

%keyboard

%% Plot

x=y(:,1); % convert from m to cm
v=y(:,2); % convert from m/s to cm/s
Fm=y(:,3);

% put in switch between null, protraction, retraction by hand here:
pro=(t>=30).*(t<=390);
ret=(t>390);
nul=(t<30);

Ftot=Fk(x,v,pro,ret,nul)+Fm;

figure(1)
clf
subplot(4,1,1)
plot(tspan(1:length(x)),x,'LineWidth',3)
set(gca,'FontSize',20)
ylabel('x')
xlim([tmin,tspan(length(x))])

subplot(4,1,2)
plot(tspan(1:length(x)),v,'LineWidth',3);
ylabel('dx/dt')
set(gca,'FontSize',20)

subplot(4,1,3)
plot(tspan(1:length(x)),Ftot,'LineWidth',3);
ylabel('Ftot')
set(gca,'FontSize',20)

subplot(4,1,4)
plot(tspan,xtarget(tspan,dx),'LineWidth',3);
xlim([tmin,tspan(length(x))])
ylabel('x target')
set(gca,'FontSize',20)
xlabel('Time (sec)')