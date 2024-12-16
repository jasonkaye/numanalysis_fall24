% Homework 6, Problem 2

plotsettings;
addpath ~/Documents/MATLAB/export_fig/
export = true;

%% Part a

% Plot adaptive Chebyshev nodes for n=4, p=4

n = 6;
p = 4;

xadap = adapcheb_nodes(n,p);
fig1 = figure(1);
fig1.Position = [100 100 800 200];
plot(xadap,zeros(size(xadap)),'.','markersize',20)
xlabel('$x$')
set(gca,'fontsize',labelsize)

%% Part c

f1 = @(x) exp(-x);
f2 = @(x) exp(-10000*x);

% eta = 1e-4;
% f1 = @(x) eta^2./(eta^2+x.^2);
% f2 = @(x) 1./(1+x.^2);

n = 15;
p = 16;
xadap = adapcheb_nodes(n,p); % Adaptive Cheb grid
f1x = f1(xadap);
f2x = f2(xadap);

xglob = adapcheb_nodes(1,n*p); % Global Cheb grid of np nodes
f1glob = f1(xglob);
f2glob = f2(xglob);

nplot = 10000;
x = linspace(0,1,nplot+1)';     % Dense plotting grid
x(1) = [];

% Evaluate f1, f2, and their interpolants on dense grid
[p1,p2,p1glob,p2glob] = deal(zeros(size(x)));
f1true = f1(x);
f2true = f2(x);
for i=1:nplot
    p1(i) = adapcheb_interp(n,p,f1x,x(i));
    p2(i) = adapcheb_interp(n,p,f2x,x(i));
    p1glob(i) = adapcheb_interp(1,n*p,f1glob,x(i));
    p2glob(i) = adapcheb_interp(1,n*p,f2glob,x(i));
end

figure(2);
subplot(3,1,1)
plot(x,f1true,'-',x,p1,'--k',x,f2true,'-',x,p2,'--r')
xlabel('$x$')
legend('$f_1(x)$','$p_1(x)$','$f_2(x)$','$p_2(x)$')
set(gca,'fontsize',labelsize)

subplot(3,1,2)
loglog(x,abs(f1true-p1),'-',x,abs(f2true-p2),'-')
ylim([1e-18 1e0])
xlabel('$x$')
ylabel('Error')
title('Adaptive interpolant')
legend('$f_1$','$f_2$')
set(gca,'fontsize',labelsize)

subplot(3,1,3)
loglog(x,abs(f1true-p1glob),'-',x,abs(f2true-p2glob),'-')
ylim([1e-18 1e0])
xlabel('$x$')
ylabel('Error')
title('Global interpolant')
legend('$f_1$','$f_2$')
set(gca,'fontsize',labelsize)


 
if export
    figure(1);
    export_fig('../figs/2a.pdf');

    figure(2);
    export_fig('../figs/2d.pdf');
end