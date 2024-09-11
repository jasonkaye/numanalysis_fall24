% Solving equations of projectile motion for initial angle
%
% From Lectures 1 & 2; demonstrates a simple root-finding task.

g = 9.8;    % Gravitational constant
v0 = 15;    % Initial velocity
d = 10;     % Desired distance

theta = linspace(0,pi/2,100);

% Solve f(theta) = 0 to find correct release angle
f = @(theta) (v0^2/g)*sin(2*theta) - d; 

figure(1);
plot(theta,f(theta),'.-'); % Plot f
xlabel('\theta','FontSize',30)
ylabel('f(\theta)','FontSize',30)

% Find a solution of f(theta) = 0 using built-in MATLAB solver
theta0 = 0;                  % Initial guess
theta_true = fzero(f,theta0) % Output solution
residual = f(theta0)         % Output residual 

% Plot solution
hold on;
plot(theta_true,f(theta_true),'o'); hold off

% Try bisection method
addpath functions/
itermax = 30;
a = 0;
b = pi/4;
theta = bisection(f,a,b,itermax);
disp(['Residual of bisection = ',num2str(abs(f(theta)))]);

% Try Newton's method
theta0 = 0.02;
fp = @(theta) 2*(v0^2/g)*cos(2*theta);
itermax = 4;
theta = newton(f,fp,theta0,itermax);
disp(['Residual of Newton = ',num2str(abs(f(theta)))]);



