% Homework 4, Problem 3

plotsettings;
addpath ~/Documents/MATLAB/export_fig/
export = true;

%
%% Part b

n = 100; % Number of grid points

% Form matrix of second derivative
A = 2*eye(n) - diag(ones(n-1,1),1) - diag(ones(n-1,1),-1);

% Obtain charge density
mu = 1/2;
sig = 0.05;
q = @(x) 1/(sqrt(2*pi)*sig)*exp(-1/2*(x-mu).^2/sig^2);

% Spatial grid
h = 1/(n+1);
x = 0:h:1;

% Form right-hand side
b = h^2*q(x(2:end-1))';

% Solve system
u = zeros(n+2,1);
u(2:end-1) = A\b;

% Plot
figure(1);
plot(x,u,'.-')
xlabel('$x$')
ylabel('$u(x)$')
set(gca,'fontsize',labelsize)

%% Part c

% Compute eigenfunctions of -d^2/dx^2
[V,D] = eig(1/h^2*A);
[v1,v2,v3] = deal(zeros(n+2,1));
v1(2:end-1) = V(:,1);
v2(2:end-1) = V(:,2);
v3(2:end-1) = V(:,3);

% Output three leading eigenvalues
fprintf('First eigenvalue: %f\n',D(1,1));
fprintf('Second eigenvalue: %f\n',D(2,2));
fprintf('Third eigenvalue: %f\n',D(3,3));

% Plot first three eigenfunctions
myfig = figure(2);
myfig.Position = [100,100,800,800];
subplot(2,1,1)
plot(x,v1,'.-',x,v2,'.-',x,v3,'.-')
xlabel('$x$')
ylabel('$u_n(x)$')
legend('$n=1$','$n=2$','$n=3$')
set(gca,'fontsize',labelsize)

subplot(2,1,2)
plot(x,v1.^2,'.-',x,v2.^2,'.-',x,v3.^2,'.-')
xlabel('$x$')
ylabel('$|u_n(x)|^2$')
legend('$n=1$','$n=2$','$n=3$')
set(gca,'fontsize',labelsize)


if export
    figure(1);
    export_fig('../figs/3b.pdf');

    figure(2);
    export_fig('../figs/3c.pdf');
end

