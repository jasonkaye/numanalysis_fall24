% Polynomial interpolation using barycentric formula
%
% Inputs
% xeval     Point at which to evaluate interpolant
% x         Interpolation nodes
% y         Data values
% w         Barycentric weights
%
% Output
% p         Interpolant evaluated at xeval

function p = baryinterp(xeval,x,y,w)

n = length(x);

% If xeval is an interpolation node, return the corresponding data value
for i=1:n
    if (xeval==x(i))    
        p = y(i);
        return;
    end
end

numer = 0;
denom = 0;

% Otherwise, use barycentric formula
for i=0:n-1
    c = w(i+1)/(xeval-x(i+1));
    denom = denom + c;
    numer = numer + c*y(i+1);
end

p = numer/denom;

end