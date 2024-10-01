% Homework 1, Problem 2

plotsettings;
addpath ../../../code/functions
addpath ~/Documents/MATLAB/export_fig/
export = false;

%
%% Part b

f = @(x) cos(exp(x));       % Define the function
x = linspace(-1,1,100);     % Get a grid
figure(1);
plot(x,f(x),'.-');
xlabel('$x$');
ylabel('$f(x)$');
title('$f(x) = \cos(\exp(x))$');
set(gca,'fontsize',labelsize)

xtrue = log(pi/2);                  % True root in [-1,1]

[x_bisection,x_iter] = bisection_tol(f, -1, 1, 50, 1e-10); % Find root using bisection method

fp    = @(x) -sin(exp(x))*exp(x);           % Derivative of f
x0 = 0;                                     % Initial guess
x_newton = newton_tol(f,fp,x0,50,1e-10);    % Find root using Newton's method

x1 = 1;                                         % Second initial guess
x_secant = secant_tol(f, x0, x1, 50, 1e-10);    % Find root using secant method

% Compute errors

abs(x_bisection-xtrue)
abs(x_newton-xtrue)
abs(x_secant-xtrue)

%% Part d

tols = logspace(-1,-10,10); % Error tolerances
[niter_bisection,niter_newton,niter_secant] = deal(zeros(10,1)); % Initialize vectors to store number of iterations
itermax = 50; % Maximum number of iterations

a = -1; b = 1; % Interval for bisection method
x0 = 0; % Initial guess for Newton's method
x1 = 1; % Second initial guess for secant method
for i=1:10
    [~,~,niter_bisection(i)] = bisection_tol(f, a, b, itermax, tols(i));
    [~,~,niter_newton(i)] = newton_tol(f, fp, x0, itermax, tols(i));
    [~,~,niter_secant(i)] = secant_tol(f, x0, x1, itermax, tols(i));
end

figure(2);
semilogx(tols,niter_bisection,'o-'); hold on
semilogx(tols,niter_newton,'o-');
semilogx(tols,niter_secant,'o-'); hold off
xlabel('Error tolerance');
ylabel('Number of iterations');
legend('Bisection','Newton','Secant');
title('\# of iterations vs. error tolerance');
set(gca,'fontsize',labelsize)

if export
    figure(2);
    export_fig('../figs/2d.pdf');
end