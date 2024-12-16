% Adaptive piecewise Chebyshev interpolation on [0,1] with dyadic refinement into origin
% Inputs:
%   n: number of panels
%   p: # Chebyshev nodes per panel
%   f: values of function to interpolate at nodes xadap
%   x: evaluation point
% Outputs:
%   p: interpolated value of f at x
function p = adapcheb_interp(n,p,f,x)

  % Determine index of panel containing x
  k = max(1,n+ceil(log2(x)));

  % Determine panel endpoints
  if (k == 1)
    a = 0;
  else
    a = 2^(-(n-(k-1)));
  end
  b = 2^(-(n-k));

  % Map x to [-1,1]
  xx = 2*(x-a)/(b-a)-1;

  % Chebyshev nodes on [-1,1] and barycentric weights
  xc = cos((2*(0:p-1)'+1)/(2*p)*pi);
  wc = (-1).^(0:p-1)'.*sin((2*(0:p-1)'+1)/(2*p)*pi);

  % Barycentric interpolation
  p = baryinterp(xx,xc,f(:,k),wc);

end