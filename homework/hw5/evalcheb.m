% Evaluate Chebyshev expansion by three-term recurrence
% Inputs:
%   x: evaluation point
%   c: coefficients of expansion
% Outputs:
%   p: value of expansion at x
function p = evalcheb(x,c)

n = length(c);

% Treat n = 0 and n = 1 as special cases
if (n==1)
    p = c;
    return;
elseif (n==2)
    p = c(1) + c(2)*x;
    return;
end

% Run three-term recurrence to compute T_n(x), and build expansion
tnm1 = 1;
tn = x;
p = c(1)*tnm1 + c(2)*tn;
for i=3:n
    tnp1 = 2*x*tn - tnm1;
    p = p + c(i)*tnp1;
    tnm1 = tn;
    tn = tnp1;
end

end