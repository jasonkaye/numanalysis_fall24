% Homework 6, Problem 4

plotsettings;
addpath ~/Documents/MATLAB/export_fig/
export = false;

%% Part a

n = 3;
[xgl,wgl]=lgwt(n,0,1);  % Gauss-Legendre nodes and weights

for k=0:10
    intgl = sum(wgl.*xgl.^k);
    inttrue = 1/(k+1);
    fprintf('k = %d: Gauss-Legendre quadrature error = %.2e\n',k,abs(intgl-inttrue))
end

%% Part b

ns = 1:60;
err = zeros(size(ns));
for i=1:length(ns)
    n = ns(i);
    [xgl,wgl]=lgwt(n,-6,6);  % Gauss-Legendre nodes and weights
    intgl = sum(wgl.*exp(-xgl.^2));
    err(i) = abs(intgl-sqrt(pi));
end

figure(1)
semilogy(ns,err,'o-')
xlabel('$n$')
ylabel('Quadrature error')
ylim([1e-16,1e2])
set(gca,'fontsize',labelsize)
 
if export
    figure(1);
    export_fig('../figs/4b.pdf');
end