% Demo: polynomial interpolation at equispaced nodes

addpath functions
plotsettings;

%% Plot some Lagrange basis functions for equispaced nodes
n = 5;
a = -1;
b = 1;
xeq = linspace(a,b,n);      % Equispaced interpolation nodes

nplot = 1000;
x = linspace(a,b,nplot).';  % Plotting grid

phi = zeros(nplot,n);
for i=0:n-1
    for k=1:nplot
        phi(k,i+1) = lagrangep(x(k),i,xeq); % Evaluate ith Lagrange basis function at x(k)
    end
end

figure(1);
plot(x,phi,'.-')
legend('$\phi_0(x)$','$\phi_1(x)$','$\phi_2(x)$','$\phi_3(x)$','$\phi_4(x)$')
xlabel('$x$')
title('Lagrange basis functions for equispaced nodes')
set(gca,'fontsize',labelsize)

%% Interpolate a function

n = 50;                 % Number of interpolation nodes

% A few functions to choose from
f = @(x) sin(2*pi*x);
% f = @(x) 1./(1+25*x.^2);
% f = @(x) tan(x);

xeq = linspace(a,b,n);  % Equispaced interpolation nodes

% Barycentric interpolation weights for equispaced nodes
w = zeros(n,1);
for i=0:n-1
    w(i+1) = (-1)^i*nchoosek(n-1,i);
end

y = f(xeq);            % Function values at interpolation nodes

[p1,p2] = deal(zeros(nplot,1));
for k=1:nplot
    p1(k) = lagrangeinterpolant(x(k),xeq,y);
    p2(k) = baryinterp(x(k),xeq,y,w);
end

hfig = figure(2);
hfig.Position(3:4) = [1000 600];
subplot(2,1,1)
plot(x,f(x),'-','Linewidth',4); hold on
plot(x,p1,'.-')
plot(x,p2,'--')
plot(xeq,f(xeq),'o'); hold off
legend('True function','Lagrangre interpolant','Barycentric interpolant','Data points')
xlabel('$x$')
title('Polynomial interpolation at equispaced nodes')
set(gca,'fontsize',labelsize)

subplot(2,1,2)
semilogy(x,abs(f(x)-p1),'.-'); hold on
semilogy(x,abs(f(x)-p2),'.-'); hold off
xlabel('$x$')
ylabel('Error')
legend('Lagrange interpolant','Barycentric interpolant')
title('Interpolation error')
set(gca,'fontsize',labelsize)



% Evaluate polynomial interpolant by expansion in Lagrange basis
function p = lagrangeinterpolant(xeval,x,y)

n = length(x);
p = 0;
for i=0:n-1
    p = p + y(i+1)*lagrangep(xeval,i,x);
end

end

% Evaluate ith Lagrange basis function
function phi = lagrangep(xeval,i,x)

n = length(x);
phi = 1;
for j=0:n-1
    if (j==i)
        continue;
    end
    phi = phi*(xeval-x(j+1))/(x(i+1)-x(j+1));
end

end