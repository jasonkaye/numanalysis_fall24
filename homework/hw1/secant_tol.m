% Solve f(x)=0 for scalar x by secant method, w/ stopping based on error tolerance
%
% Inputs
% f         Function handle for f
% x0        First initial guess
% x1        Second initial guess
% itermax   Number of iterations
% tol       Error tolerance
%
% Output
% x         Approximate root of f(x)=0
% xiter     Vector containing all iterates of Newton's method
% niter     Number of iterations taken

function [x,xiter,niter] = secant_tol(f,x0,x1,itermax,tol)

xiter = zeros(itermax+1,1);   % Store each iterate of secant method
xiter(1) = x0;                % Initial guess
xiter(2) = x1;                % Initial guess
for i=2:itermax
    if (f(xiter(i))==f(xiter(i-1))) % If val of f agrees w/ previous iteration, terminate to avoid division by zero
        x = xiter(i);
        xiter(i+1:end) = [];
        return;
    end

    xiter(i+1) = xiter(i) - f(xiter(i))*(xiter(i)-xiter(i-1))/(f(xiter(i))-f(xiter(i-1))); % Secant iteration

    if (abs(xiter(i+1)-xiter(i)) <= tol) % If error tolerance has been met, terminate
        niter = i;
        x = xiter(i+1);
        xiter(i+2:end) = [];
        return;
    end
end

x = xiter(itermax+1); % Final result is current iterate

end