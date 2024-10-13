% Homework 2, Problem 2

plotsettings;
addpath ../../../../code/functions
addpath ~/Documents/MATLAB/export_fig/
export = false;

%% Part b

f1 = @(x1,x2) 5*x1 + x1.*x2.^2 + cos(3*x2).^2 - 1;
f2 = @(x1,x2) exp(2*x1-x2)+4*sin(x2) - 2;
x = linspace(-1,1,30);
[X,Y] = meshgrid(x);
figure(1);
mesh(X,Y,f1(X,Y),'FaceAlpha','0.5','FaceColor','red'); hold on;
mesh(X,Y,f2(X,Y),'FaceAlpha','0.5','FaceColor','green');
mesh(X,Y,zeros(size(X)),'FaceAlpha','0.5','FaceColor','blue');
xlabel('$x_1$'); ylabel('$x_2$'); zlabel('z');
set(gca,'fontsize',labelsize)
hold off

%% Part c
% Newton's method to obtain root of f(x1,x2) = (f1(x1,x2),f2(x1,x2))

% Define partial derivatives of f
d1f1 = @(x1,x2) 5 + x2.^2;
d1f2 = @(x1,x2) 2*exp(2*x1-x2);
d2f1 = @(x1,x2) 2*x1.*x2 - 6*sin(3*x2).*cos(3*x2);
d2f2 = @(x1,x2) -exp(2*x1-x2) + 4*cos(x2);

x0 = [0.1; 0.3];    % Initial guess
tol = 1e-10;        % Residual tolerance
maxiter = 10;       % Maximum number of iterations

x = x0;                               % Initial iterate
fk = [f1(x(1),x(2)); f2(x(1),x(2))];  % Evaluate f at initial iterate
for k=1:maxiter
    J = [d1f1(x(1),x(2)), d2f1(x(1),x(2)); d1f2(x(1),x(2)), d2f2(x(1),x(2))]; % Compute Jacobian
    x = x - J\fk;                               % Newton step
    fk = [f1(x(1),x(2)); f2(x(1),x(2))];        % Evaluate f at current iterate
    if norm(fk) < tol                           % Check residual error
        break;
    end
end

% Print the result and residual error
fprintf('x = [%.15f, %.15f]\n',x(1),x(2));
fprintf('Residual error: |f(x)| = %.5e\n',norm(fk));
fprintf('Number of iterations: %d\n',k);

if export
    figure(1);
    export_fig('../figs/2b.pdf');
end