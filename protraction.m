function [Kk,Km,Dm,Dk] = protraction(A1,A2,Dx,Xo,C1,C2,C3,E1,F1,F2,F3,x)
%Protraction Function
for i = 1:length(x)
    Kk(i) = A2+(A1-A2)/(1+exp((x(i)-Xo)/Dx));
    Km(i) = C1+C2*x(i)+C3*x(i)^2;
    Dk(i) = E1;
    Dm(i) = F1 + F2*x(i)+F3*x(i)^2;
end
end

