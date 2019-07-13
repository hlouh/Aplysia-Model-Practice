% script SuttonEtAl2004JCompPhysFig5.m

cd('C:\Users\hsing\Desktop\Slug Model Practice\Aplysia-Model-Practice')
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
dx=0.0016; % m
xtargetplot=xtarget(tspan,dx);
figure
subplot(7,1,6:7)
plot(tspan,xtargetplot,'LineWidth',2)
xlabel('Time(s)')
ylabel('Displacement(m)')
set(gca,'FontSize',10)
%% Run
tstep=tspan(2)-tspan(1); % size of each time step
Fmstop=0; % N
Fm=[]; % N
tall=[]; % might be able to just use tspan?
for i=1:20
    %protraction
    if i<13
%       during the plateau btw each step
        tstart=30*(i-1);
        tstop=30*i-tstep;
        Fmstart=Fmstop;
        x=(i-1)*dx; % m
        v=0; % m/sec
        pro=1; ret=0; nul=0;
        jump=0;
        [t,y]=ode23(@(t,y)DFmDt(t,y,x,v,pro,ret,nul,jump),[tstart,tstop],Fmstart);
        newFm=y(:,1);
        Fm=[Fm;newFm];
        tall=[tall;t];
        Fmstop=newFm(end);
        %at each step increase
        tstart = 30*i-tstep;
        tstop = 30*i;
        Fmstart=Fmstop;
        x=(i-1)*dx+dx/tstep*(tstart-((30*i)-tstep)); % m
        v=dx/tstep; % m/sec
        jump=1;
        [t,y]=ode23(@(t,y)DFmDt(t,y,x,v,pro,ret,nul,jump),[tstart,tstop],Fmstart);
        newFm=y(:,1);
        Fm=[Fm;newFm];
        tall=[tall;t];
        Fmstop=newFm(end);
%     retraction 
    elseif i==13
%       during the plateau btw each step
        tstart=30*(i-1);
        tstop=30*i-tstep;
        Fmstart=Fmstop;
        x=(i-1)*dx; % m
        v=0; % m/sec
        pro=1; ret=0; nul=0;
        jump=0;
        [t,y]=ode23(@(t,y)DFmDt(t,y,x,v,pro,ret,nul,jump),[tstart,tstop],Fmstart);
        newFm=y(:,1);
        Fm=[Fm;newFm];
        tall=[tall;t];
        Fmstop=newFm(end);
        %at the step increase
        tstart = 30*i-tstep;
        tstop = 30*i;
        Fmstart=Fmstop;
        x=(13-(i-14))*dx-dx/tstep*(tstart-((30*i)-tstep)); % m
        v=-1*dx/tstep; % m/sec
        jump=1;
        [t,y]=ode23s(@(t,y)DFmDt(t,y,x,v,pro,ret,nul,jump),[tstart,tstop],Fmstart);
        newFm=y(:,1);
        Fm=[Fm;newFm];
        tall=[tall;t];
        Fmstop=newFm(end);
    elseif 13<i
        %during the plateau btw each step
        tstart=30*(i-1);
        tstop=30*i-tstep;
        Fmstart=Fmstop;
        x=(13-(i-14))*dx; % m
        v=0; % m/sec
        pro=0; ret=1; nul=0;
        jump=0;
        [t,y]=ode23s(@(t,y)DFmDt(t,y,x,v,pro,ret,nul,jump),[tstart,tstop],Fmstart);
        newFm=y(:,1);
        Fm=[Fm;newFm];
        tall=[tall;t];
        Fmstop=newFm(end);
        %at each step increase
        tstart = 30*i-tstep;
        tstop = 30*i;
        Fmstart=Fmstop;
        x=(13-(i-14))*dx-dx/tstep*(tstart-((30*i)-tstep)); % m
        v=-1*dx/tstep; % m/sec
        jump=1;
        [t,y]=ode23s(@(t,y)DFmDt(t,y,x,v,pro,ret,nul,jump),[tstart,tstop],Fmstart);
        newFm=y(:,1);
        Fm=[Fm;newFm];
        tall=[tall;t];
        Fmstop=newFm(end);
    else
        display('Something is Seriously Wrong');
    end
end
%keyboard

%% plot the Kelvin force

%xtargetplot is in m and Fk is in N
tmin=0; % seconds
tmax=600; % seconds
tspan=linspace(tmin,tmax,20*100+1); % 20 stairsteps, 100 points each
dx=0.0016; % m
xtargetplot=xtarget(tspan,dx);


% xtargetplot=xtarget(tall,dx)';
xtargetplot=xtarget(tall,dx)';
Fkelvin=Fk(xtargetplot,0,...
    (tall'<=390).*(tall'>30),tall'>390,tall'<=30);
% figure
% plot(tall',Fkelvin,'LineWidth',3)
% ylabel('F_K')
% set(gca,'FontSize',20)

%% Total Force
Ftotal=Fm+Fkelvin';
subplot(7,1,1:4);
plot(tall,Ftotal,'LineWidth',2);
title('Passive Hinge Force Over Time');
xlabel('Time(s)');
ylabel('Force(N)');
set(gca,'FontSize',10)