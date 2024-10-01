% Solve f(x)=0 for scalar x by bisection method, w/ stopping based on error tolerance
%
% Inputs
% f         Function handle for f
% [a,b]     Initial guess interval
% itermax   Number of iterations
% tol       Error tolerance
%
% Output
% x         Approximate root of f(x)=0
% xiter     Vector containing all iterates of bisection method
% niter     Number of iterations taken
%
% Note: In bisection method, [a,b] must contain a root, and the sign of
% f(a) must differ from the sign of f(b). Otherwise, this function will
% return an empty result.

function [x,xiter,niter] = bisection_tol(f,a,b,itermax,tol)

fa = f(a);
fb = f(b);

if (sign(fa)==sign(fb))
    warning('sign(f(a)) must be different from sign(f(b)); returned empty result');
    x = [];
    xiter = [];
    niter = 0;
    return;
end

xiter = zeros(itermax+1,1);   % Store each iterate of bisection method
for i=1:itermax

    c = (a+b)/2;    % Compute midpoint
    xiter(i) = c;   % Store this iterate
    fc = f(c);      % Evaluate f at midpoint

    if (i>=2 && abs(xiter(i)-xiter(i-1)) <= tol) % If error tolerance has been met, terminate
        niter = i;
        x = c;
        xiter(i+1) = x;
        xiter(i+2:end) = [];
        return;
    end

    % Update interval
    if (sign(fa)==sign(fc))
        a = c;
        fa = fc;
    elseif (sign(fb)==sign(fc))
        b = c;
        fb = fc;
    else % Since sign(f(a))/=sign(f(b)) always, f(c)=0 in this case
        x = c;
        return;
    end

end

x = (a+b)/2; % Final iterate is current midpoint
xiter(itermax+1) = x;
niter = itermax;

end