function xout=xtarget(t,dx)

% function xout=xtarget(t,dx)
%
% Set a target displacement pattern

% target displacement, in cm
xout=dx*((t<390).*floor(t/30)+(t>=390).*floor((750-t)/30)); 
%xout=.1; 

end