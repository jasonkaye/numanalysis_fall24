% Homework 2, Problem 1

plotsettings;
addpath ../../../../code/functions
addpath ~/Documents/MATLAB/export_fig/
export = true;

%
%% Part b

f = @(x) exp(x) - x.^2 - 6*x - 9;
g = @(x) 2*log(x+3);
x1 = fzero(@(x) g(x)-x, -1);
x2 = fzero(@(x) g(x)-x, 4);

x = linspace(-3,5,100);     % Get a grid
figure(1);
plot(x,g(x),'.-',x,x,'--k'); hold on
plot(x1,g(x1),'ro',x2,g(x2),'ro'); hold off
xlabel('$x$');
ylabel('$g(x)$');
title('$g(x) = 2\log(x+3)$');
set(gca,'fontsize',labelsize)

% Part d

% Fixed point iteration for g(x)
x0 = 3.5;       % Initial guess
tol = 1e-10;    % Tolerance 
maxit = 100;    % Maximum number of iterations
x = x0;
for i=1:maxit
    x = g(x);
    if abs(f(x)) < tol
        break;
    end
end
% Print the result and residual error
fprintf('Fixed point iteration: x = %.10f\n',x);
fprintf('Residual error: |f(x)| = %.5e\n',abs(f(x)));
fprintf('Number of iterations: %d\n',i);


if export
    figure(1);
    export_fig('../figs/1b.pdf');
end