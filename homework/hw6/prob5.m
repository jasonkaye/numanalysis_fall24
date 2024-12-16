% Homework 6, Problem 4

plotsettings;
addpath ~/Documents/MATLAB/export_fig/
export = false;

ns = 1:30;
err = zeros(size(ns));
for i=1:length(ns)
    n = ns(i);
    dx = 2*pi/n;
    intptr = dx*sum(exp(cos(0:dx:2*pi-dx)));
    err(i) = abs(intptr-2*pi*besseli(0,1));
end

figure(1)
semilogy(ns,err,'o-')
xlabel('$n$')
ylabel('Quadrature error')
ylim([1e-16,1e2])
set(gca,'fontsize',labelsize)

n = ns(15);
figure(2);
dx = 2*pi/n;
x = 0:dx:2*pi-dx;
plot(x,exp(cos(x)),'o-');
xlabel('$x$')
ylabel('$f(x)$')
set(gca,'fontsize',labelsize)


 
if export
    figure(1);
    export_fig('../figs/5.pdf');
end