% Adaptive piecewise Chebyshev grid on [0,1] dyadically refined into the origin
% Inputs:
%   n: number of panels
%   p: # Chebyshev nodes per panel
% Outputs:
%   xadap: piecewise adaptive Chebyshev grid
function xadap = adapcheb_nodes(n,p)

  % Chebyshev nodes of the first kind on [-1,1]
  xc = cos((2*(0:p-1)'+1)/(2*p)*pi);

  % Panel endpoints
  endpt = zeros(n+1,1);
  endpt(1) = 0;
  endpt(2:n+1) = 2.^(-(n-(1:n)));
  
  xadap = zeros(p,n);
  for i=1:n
    a = endpt(i);                       % Panel endpoints
    b = endpt(i+1);                     
    xadap(:,i) = (b-a)/2*xc + (a+b)/2;  % Cheb nodes on [a,b]
  end
end