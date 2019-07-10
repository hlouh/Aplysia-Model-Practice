% script SuttonEtAl2004JCompPhysFig5_Kelvin_only.m

cd('/Users/pjthomas/github/hlouh/Aplysia-Model-Practice')
Parameters % load in parameters from Table I of paper
Forces % finishing loading definitions from Table I of paper.

global dx % step displacement size

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

%% plot the Kelvin force

%xtargetplot is in cm; convert to m for input to Fk
Fkplot=Fk(xtargetplot/100,0,...
    (tspan<=390).*(tspan>30),tspan>390,tspan<=30);
subplot(3,1,1:2)
plot(tspan,Fkplot,'LineWidth',3)
ylabel('F_K')
set(gca,'FontSize',20)

