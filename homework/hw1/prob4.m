% Homework 1, Problem 4

plotsettings;
addpath ../../../code/functions

f  = @(x) x.^5 - 3*x.^2 + 1;         % Define the function
fp = @(x) 5*x.^4 - 6*x;              % Derivative of f

figure(1);
x = linspace(-2,2,100);     % Get a grid
plot(x,f(x),'.-');
xlabel('$x$');
ylabel('$f(x)$');
title('$f(x) = x^5 - 3x^2 + 1$');
set(gca,'fontsize',labelsize)

%% Part a
endpoints = -2:0.25:2; % Endpoints for bisection method
ninterval = length(endpoints)-1;

roots = []; % Initialize empty vector to store roots
itermax = 50; % Max number of iterations
for i=1:ninterval
    a = endpoints(i); b = endpoints(i+1); % Define interval
    x0 = bisection_tol(f, a, b, itermax, 0.1); % Find root using bisection method to within tol 0.1
    if isempty(x0) % If bisection method fails, skip this interval
        continue;
    end
    x = newton_tol(f, fp, x0, itermax, 1e-12); % Refine root using Newton's method
    roots = [roots; x]; % Store root
end

roots

hold on; plot(roots, f(roots), 'ro'); hold off

%% Part b
a = -0.75; b = -0.5;

 % Try bisection + Newton, and count Newton iterations
x0 = bisection_tol(f, a, b, itermax, 0.1);
[~, ~, niter_newton] = newton_tol(f, fp, x0, itermax, 1e-12);

% Try bisection alone, and count iterations
[~, ~, niter_bisection] = bisection_tol(f, a, b, itermax, 1e-12);

niter_newton
niter_bisection