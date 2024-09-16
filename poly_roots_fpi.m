% Test different fixed point iteration strategies for computing roots of f(x) = x^3 + 6*x^2 - 8

f = @(x) x.^3 + 6*x.^2 - 8;

% Define three different fixed point iterations
g1 = @(x) x.^3+6*x.^2+x-8;          % This will not converge
g2 = @(x) sqrt(8./(x+6));           % This will converge
g3 = @(x) sqrt((8-x.^3)/6);         % This will converge

niter = 30;             % Number of iterations

x = 1.5;                % Initial guess
for i=1:niter
    % Three different fixed point strategies:
    % Uncomment the one you want to try, and comment out the rest

    %x = g1(x)
    %x = g2(x)
    x = g3(x);
    
    fprintf('Iteration %d: x = %.16f\n', i, x);
end

% Check residual; is result of fixed point iteration a root?
fprintf('Residual: |f(x)| = %.5e\n', abs(f(x)));