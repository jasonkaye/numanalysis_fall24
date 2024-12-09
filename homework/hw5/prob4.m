% Homework 5, Problem 4

plotsettings;
addpath ~/Documents/MATLAB/export_fig/
export = false;

%% Part b

neval = 1000;         % Evaluation grid
xeval = linspace(-1,1,neval)';

n = 40;
    
f = @(x) exp(-10*x.^2);
fp = @(x) -20*x.*exp(-10*x.^2);

[xc,wc] = chebnodeswgts(n);
fxc = f(xc);

D = chebdiff(n);
fpxc = D*fxc;

fpeval = zeros(neval,1);
for i=1:neval
    fpeval(i) = baryinterp(xeval(i),xc,fpxc,wc);
end

hfig = figure(1);
hfig.Position(3:4) = [1000 600];
subplot(2,1,1)
plot(xeval,fp(xeval),'-',xeval,fpeval,'--')
xlabel('$x$')
legend('$f^\prime(x)$','Cheb interpolant')
set(gca,'fontsize',labelsize)

subplot(2,1,2)
semilogy(xeval,abs(fp(xeval)-fpeval),'.-')
xlabel('$x$')
ylabel('Absolute error')
set(gca,'fontsize',labelsize)

%% Part e
intf = @(x) sqrt(pi)/(2*sqrt(10))*(erf(sqrt(10)*x)-erf(-sqrt(10)));

S = chebint(n);

fintxc = S*fxc;

finteval = zeros(neval,1);
for i=1:neval
    finteval(i) = baryinterp(xeval(i),xc,fintxc,wc);
end

hfig = figure(2);
hfig.Position(3:4) = [1000 600];
subplot(2,1,1)
plot(xeval,intf(xeval),'-',xeval,finteval,'--')
xlabel('$x$')
legend('$\int_0^x f(t) \, dt$','Cheb interpolant')
set(gca,'fontsize',labelsize)

subplot(2,1,2)
semilogy(xeval,abs(intf(xeval)-finteval),'.-')
xlabel('$x$')
ylabel('Absolute error')
set(gca,'fontsize',labelsize)


if export
    figure(1);
    export_fig('../figs/4b.pdf');

    figure(2);
    export_fig('../figs/4g.pdf');
end

% Get Chebyshev nodes of the first kind and barycentric interpolation weights
function [xc,wc] = chebnodeswgts(n)

xc = cos((2*(0:n-1)'+1)/(2*n)*pi);  % Chebyshev nodes
wc = (-1).^(0:n-1)'.*sin((2*(0:n-1)'+1)/(2*n)*pi); % Barycentric weights

end

