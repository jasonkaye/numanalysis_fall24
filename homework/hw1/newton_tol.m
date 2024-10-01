% Solve f(x)=0 for scalar x by Newton's method, w/ stopping based on error tolerance
%
% Inputs
% f         Function handle for f
% fp        Function handle for f'
% x0        Initial guess
% itermax   Number of iterations
% tol       Error tolerance
%
% Output
% x         Approximate root of f(x)=0
% xiter     Vector containing all iterates of Newton's method
% niter     Number of iterations taken

function [x,xiter,niter] = newton_tol(f,fp,x0,itermax,tol)

xiter = zeros(itermax+1,1);   % Store each iterate of Newton's method
xiter(1) = x0;                % Initial guess
for i=1:itermax
    xiter(i+1) = xiter(i) - f(xiter(i))/fp(xiter(i)); % Newton iteration
    if (abs(xiter(i+1)-xiter(i)) <= tol) % If error tolerance has been met, terminate
        niter = i;
        x = xiter(i+1);
        xiter(i+2:end) = [];
        return;
    end
end

x = xiter(itermax+1); % Final result is current iterate

end