% Homework 1, Problem 3

plotsettings;
addpath ../../../code/functions
addpath ~/Documents/MATLAB/export_fig/
export = true;

%
%% Part a

f = @(x) cos(exp(x));               % Define the function
fp    = @(x) -sin(exp(x))*exp(x);   % Derivative of f
xtrue = log(pi/2);                  % True root in [-1,1]

a = -1; b = 1; % Interval for bisection method
x0 = 0; % Initial guess for Newton's method
x1 = 1; % Second initial guess for secant method

itermax = 50; % Number of iterations

[~,xiter_bisection] = bisection(f, a, b, itermax);
[~,xiter_newton] = newton(f, fp, x0, itermax);
[~,xiter_secant] = secant(f, x0, x1, itermax);

err_bisection = abs(xiter_bisection - xtrue);
err_newton = abs(xiter_newton - xtrue);
err_secant = abs(xiter_secant - xtrue);

figure(1);
semilogy(1:length(xiter_bisection),err_bisection,'.-'); hold on
semilogy(1:length(xiter_newton),err_newton,'.-');
semilogy(1:length(xiter_secant),err_secant,'.-'); hold off
xlabel('Iteration');
ylabel('Error');
legend('Bisection','Newton','Secant');
title('Errors of root-finding methods for $f(x) = \cos(\exp(x))$');
set(gca,'fontsize',labelsize)
xlim([0,55]);

%% Part c
figure(2);
scatter(log10(err_bisection(1:end-1)),log10(err_bisection(2:end)), 20, 'filled'); hold on
scatter(log10(err_newton(1:end-1)),log10(err_newton(2:end)), 20, 'filled');
scatter(log10(err_secant(1:end-1)),log10(err_secant(2:end)), 20, 'filled');
x = linspace(-15, 0, 100);
plot(x, x, 'k--');
plot(x, 2*x, 'r--');
plot(x, (1+sqrt(5))/2*x, 'b--'); hold off
xlabel('$\log_{10}(E_{k-1})$');
ylabel('$\log_{10}(E_k)$');
legend('Bisection','Newton','Secant','$y=x$','$y=2x$','$y=\frac{1+\sqrt{5}}{2} x$', 'Location', 'SouthEast');
title('Convergence rates of root-finders for $f(x) = \cos(\exp(x))$');
xlim([-17, 0]);
set(gca,'fontsize',labelsize)

if export
    figure(1);
    export_fig('../figs/3a.pdf');
    figure(2);
    export_fig('../figs/3c.pdf');
end