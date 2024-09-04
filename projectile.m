% Equations of projectile motion

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
theta0 = 0;              % Initial guess
theta0 = fzero(f,theta0) % Output solution
residual = f(theta0)     % Output residual 

% Plot solution
hold on;
plot(theta0,f(theta0),'o'); hold off