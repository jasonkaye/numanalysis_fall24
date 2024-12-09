% Matrix of Chebyshev spectral indefinite integration "values to values"
% Inputs:
%   n: evaluation point
% Outputs:
%   D: spectral indefinite integration matrix
function S = chebint(n)

% Chebyshev coefficients to values matrix
T = cos(((0:n-1)'+1/2)*(0:n-1)*pi/n);

% Chebyshev coefficients to values differentiation matrix
Scv = zeros(n);
for k=0:n-1
    for j=0:n-1
        if k==0
            Scv(j+1,k+1) = 1 + cos((j+1/2)*pi/n);
        elseif k==1
            Scv(j+1,k+1) = -1/4 + 1/4*cos(2*(j+1/2)*pi/n);
        else
            Scv(j+1,k+1) = 1/2*(1/(k+1)*cos((k+1)*(j+1/2)*pi/n) - 1/(k-1)*cos((k-1)*(j+1/2)*pi/n)) + (-1)^k/(1-k^2);
        end
    end
end

% Values to values differentiation matrix
S = Scv/T;

end