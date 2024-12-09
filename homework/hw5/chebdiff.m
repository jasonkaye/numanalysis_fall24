% Matrix of Chebyshev spectral differentiation "values to values"
% Inputs:
%   n: evaluation point
% Outputs:
%   D: spectral differentiation matrix
function D = chebdiff(n)

% Chebyshev coefficients to values matrix
T = cos(((0:n-1)'+1/2)*(0:n-1)*pi/n);

% Chebyshev coefficients to values differentiation matrix
k = (0:n-1);
j = (0:n-1)';
Tp = k.*(sin((j+1/2)*k*pi/n)./sin((j+1/2)*pi/n));

% Values to values differentiation matrix
D = Tp/T;

end