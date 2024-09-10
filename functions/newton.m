% Solve f(x)=0 for scalar x by Newton's method
%
% Inputs
% f         Function handle for f
% fp        Function handle for f'
% x0        Initial guess
% itermax   Number of iterations
%
% Output
% x         Approximate root of f(x)=0
% xiter     Vector containing all iterates of Newton's method

function [x,xiter] = newton(f,fp,x0,itermax)

xiter = zeros(itermax+1,1);   % Store each iterate of Newton's method
xiter(1) = x0;                % Initial guess
for i=1:itermax
    xiter(i+1) = xiter(i) - f(xiter(i))/fp(xiter(i)); % Newton iteration
end

x = xiter(itermax+1); % Final result is current iterate

end