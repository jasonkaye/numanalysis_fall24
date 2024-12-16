% Homework 6, Problem 3

plotsettings;
addpath ~/Documents/MATLAB/export_fig/
export = true;

%% Part d

f = @(x) sin(x);
D = @(x,h) (2/3*(f(x+h)-f(x-h)) - 1/12*(f(x+2*h)-f(x-2*h)))/h;

hs = 2.^(-(1:40));

x = 0.1;

err = zeros(size(hs));
for i=1:length(hs)
    err(i) = abs(D(x,hs(i))-cos(x));
end

figure(1);
loglog(hs,err,'o-',hs,hs.^4,'--k')
ylim([1e-16,1e0])
xlabel('$h$')
legend('Error','$\mathcal{O}(h^4)$','Location','NorthWest')
set(gca,'fontsize',labelsize)

 
if export
    figure(1);
    export_fig('../figs/3d.pdf');
end