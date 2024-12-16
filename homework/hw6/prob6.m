% Homework 6, Problem 4

plotsettings;
addpath ~/Documents/MATLAB/export_fig/
export = false;

a = -6;
b = 6;
f = @(x) exp(-x.^2);

ns = 10.^(1:8);
err = zeros(size(ns));
for i=1:length(ns)
    n = ns(i);
    x = a + (b-a)*rand(n,1);
    intmc = (b-a)/n*sum(f(x));
    err(i) = abs(intmc-sqrt(pi));
end

figure(1)
loglog(ns,err,'o-',ns,1./sqrt(ns),'--k')
xlabel('$n$')
legend('Monte Carlo error','$\mathcal{O}(n^{-1/2})$','Location','NorthEast')
set(gca,'fontsize',labelsize)

if export
    figure(1);
    export_fig('../figs/6.pdf');
end