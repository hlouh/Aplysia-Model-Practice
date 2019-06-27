function [Kk,Km,Dm,Dk] = retraction(B1,B2,B3,B4,D1,D2,E1,G1,G2,x)
%Retraction Function
for i=1:length(x)
%     if x(i) > 0.0091*m
    if x(i) > 0.0091
        Kk(i) = B1+B2*x(i)+B3*x(i)^2+B4*x(i)^3;
    else
        Kk(i) = 0;
    end
%     if x(i) > 0.003*m
    if x(i) > 0.003
        Km(i) = D1 + D2*x(i);
    else
        Km(i) = 0;
    end
    Dk(i) = E1;
    Dm(i) = G1+G2*x(i);
end
end

