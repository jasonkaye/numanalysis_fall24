% Homework 5, Problem 1

plotsettings;
addpath ~/Documents/MATLAB/export_fig/
addpath ../code/functions/baryinterp.m
export = false;

%% Part a

neval = 1000;         % Evaluation grid
xeval = linspace(-1,1,neval)';

f = @(x,alpha) 1./(1+alpha^2*x.^2);
alpha1 = 2;
alpha2 = 4;
alpha3 = 8;

n = 25;
[xc,wc] = chebnodeswgts(n);  % Chebyshev nodes and barycentric weights
fvals = zeros(n,3);
fvals(:,1) = f(xc,alpha1);
fvals(:,2) = f(xc,alpha2);
fvals(:,3) = f(xc,alpha3);

feval = zeros(neval,3);     % Chebyshev interpolant of f on dense grid
for j=1:3                   % Loop through alpha
    for i=1:neval           % Loop through evaluation nodes
        feval(i,j) = baryinterp(xeval(i),xc,fvals(:,j),wc);
    end
end

figure(1);
plot(xeval,f(xeval,alpha1),'-',xeval,f(xeval,alpha2),'-',xeval,f(xeval,alpha3),'-'); hold on
plot(xeval,feval,'--k'); hold off
legend('$\alpha=2$','$\alpha=4$','$\alpha=8$')
xlabel('$x$')
set(gca,'fontsize',labelsize)

ns = 10:20:300; 
err = zeros(length(ns),3);
for k=1:length(ns)
    n = ns(k);
    [xc,wc] = chebnodeswgts(n);  % Chebyshev nodes and barycentric weights
    fvals = zeros(n,3);
    fvals(:,1) = f(xc,alpha1);
    fvals(:,2) = f(xc,alpha2);
    fvals(:,3) = f(xc,alpha3);

    for j=1:3               % Loop through alpha
        for i=1:neval       % Loop through evaluation nodes
            feval(i,j) = baryinterp(xeval(i),xc,fvals(:,j),wc);
        end
    end

    err(k,1) = max(abs(feval(:,1)-f(xeval,alpha1)));
    err(k,2) = max(abs(feval(:,2)-f(xeval,alpha2)));
    err(k,3) = max(abs(feval(:,3)-f(xeval,alpha3)));
end

figure(2);
semilogy(ns,err,'.-')
legend('$\alpha=2$','$\alpha=4$','$\alpha=8$')
xlabel('Number of Chebyshev nodes')
ylabel('Max absolute error')
set(gca,'fontsize',labelsize)


%% Part b

neval = 10000;         % Evaluation grid
xeval = linspace(-1,1,neval)';
    
f = @(x) abs(x);

n = 25;
[xc,wc] = chebnodeswgts(n);  % Chebyshev nodes and barycentric weights
fvals = f(xc);

feval = zeros(neval,1);     % Chebyshev interpolant of f on dense grid
for i=1:neval           % Loop through evaluation nodes
    feval(i) = baryinterp(xeval(i),xc,fvals,wc);
end

figure(3);
plot(xeval,f(xeval),'-',xeval,feval,'--k');
xlabel('$x$')
legend('$f(x)$', 'Interpolant')
set(gca,'fontsize',labelsize)

ns = 2.^(2:11); 
err = zeros(size(ns));
for k=1:length(ns)
    n = ns(k);
    [xc,wc] = chebnodeswgts(n);  % Chebyshev nodes and barycentric weights
    fvals = f(xc);

    for i=1:neval       % Loop through evaluation nodes
        feval(i) = baryinterp(xeval(i),xc,fvals,wc);
    end

    err(k) = max(abs(feval-f(xeval)));
end

figure(4);
loglog(ns,err,'.-',ns,2./ns,'--k')
xlim([1e0 1e4])
xlabel('Number of Chebyshev nodes')
legend('Max absolute error','$\mathcal{O}(n^{-1})$')
set(gca,'fontsize',labelsize)

%% Part c

neval = 10000;         % Evaluation grid
xeval = linspace(-1,1,neval)';
    
f = @(x) x.^2.*(x>0);

n = 25;
[xc,wc] = chebnodeswgts(n);  % Chebyshev nodes and barycentric weights
fvals = f(xc);

feval = zeros(neval,1);     % Chebyshev interpolant of f on dense grid
for i=1:neval           % Loop through evaluation nodes
    feval(i) = baryinterp(xeval(i),xc,fvals,wc);
end

figure(5);
plot(xeval,f(xeval),'-',xeval,feval,'--k');
xlabel('$x$')
legend('$f(x)$', 'Interpolant')
set(gca,'fontsize',labelsize)

ns = 2.^(2:11); 
err = zeros(size(ns));
for k=1:length(ns)
    n = ns(k);
    [xc,wc] = chebnodeswgts(n);  % Chebyshev nodes and barycentric weights
    fvals = f(xc);

    for i=1:neval       % Loop through evaluation nodes
        feval(i) = baryinterp(xeval(i),xc,fvals,wc);
    end

    err(k) = max(abs(feval-f(xeval)));
end

figure(6);
loglog(ns,err,'.-',ns,1./ns.^2,'--k')
xlim([1e0 1e4])
xlabel('Number of Chebyshev nodes')
legend('Max absolute error','$\mathcal{O}(n^{-2})$')
set(gca,'fontsize',labelsize)


%% Part d
neval = 1000;         % Evaluation grid
xeval = linspace(-1,1,neval)';

f = @(x,alpha) exp(-alpha^2*x.^2);
alpha1 = 2;
alpha2 = 4;
alpha3 = 8;

n = 25;
[xc,wc] = chebnodeswgts(n);  % Chebyshev nodes and barycentric weights
fvals = zeros(n,3);
fvals(:,1) = f(xc,alpha1);
fvals(:,2) = f(xc,alpha2);
fvals(:,3) = f(xc,alpha3);

feval = zeros(neval,3);     % Chebyshev interpolant of f on dense grid
for j=1:3                   % Loop through alpha
    for i=1:neval           % Loop through evaluation nodes
        feval(i,j) = baryinterp(xeval(i),xc,fvals(:,j),wc);
    end
end

figure(7);
plot(xeval,f(xeval,alpha1),'-',xeval,f(xeval,alpha2),'-',xeval,f(xeval,alpha3),'-'); hold on
plot(xeval,feval,'--k'); hold off
legend('$\alpha=2$','$\alpha=4$','$\alpha=8$')
xlabel('$x$')
set(gca,'fontsize',labelsize)

ns = 10:10:100; 
err = zeros(length(ns),3);
for k=1:length(ns)
    n = ns(k);
    [xc,wc] = chebnodeswgts(n);  % Chebyshev nodes and barycentric weights
    fvals = zeros(n,3);
    fvals(:,1) = f(xc,alpha1);
    fvals(:,2) = f(xc,alpha2);
    fvals(:,3) = f(xc,alpha3);

    for j=1:3               % Loop through alpha
        for i=1:neval       % Loop through evaluation nodes
            feval(i,j) = baryinterp(xeval(i),xc,fvals(:,j),wc);
        end
    end

    err(k,1) = max(abs(feval(:,1)-f(xeval,alpha1)));
    err(k,2) = max(abs(feval(:,2)-f(xeval,alpha2)));
    err(k,3) = max(abs(feval(:,3)-f(xeval,alpha3)));
end

figure(8);
semilogy(ns,err,'.-')
legend('$\alpha=2$','$\alpha=4$','$\alpha=8$')
xlabel('Number of Chebyshev nodes')
ylabel('Max absolute error')
set(gca,'fontsize',labelsize)

%% Part e
neval = 1000;         % Evaluation grid
xeval = linspace(-1,1,neval)';

f = @(x,alpha) sin(alpha*x);
alpha1 = 10;
alpha2 = 50;
alpha3 = 100;


feval = zeros(neval,3);     % Chebyshev interpolant of f on dense grid

ns = 5:5:150; 
err = zeros(length(ns),3);
for k=1:length(ns)
    n = ns(k);
    [xc,wc] = chebnodeswgts(n);  % Chebyshev nodes and barycentric weights
    fvals = zeros(n,3);
    fvals(:,1) = f(xc,alpha1);
    fvals(:,2) = f(xc,alpha2);
    fvals(:,3) = f(xc,alpha3);

    for j=1:3               % Loop through alpha
        for i=1:neval       % Loop through evaluation nodes
            feval(i,j) = baryinterp(xeval(i),xc,fvals(:,j),wc);
        end
    end

    err(k,1) = max(abs(feval(:,1)-f(xeval,alpha1)));
    err(k,2) = max(abs(feval(:,2)-f(xeval,alpha2)));
    err(k,3) = max(abs(feval(:,3)-f(xeval,alpha3)));
end

figure(9);
semilogy(ns,err,'.-')
legend('$\alpha=10$','$\alpha=50$','$\alpha=100$')
xlabel('Number of Chebyshev nodes')
ylabel('Max absolute error')
set(gca,'fontsize',labelsize)


if export
    figure(1);
    export_fig('../figs/1a1.pdf');

    figure(2);
    export_fig('../figs/1a2.pdf');

    figure(3);
    export_fig('../figs/1b1.pdf');

    figure(4);
    export_fig('../figs/1b2.pdf');

    figure(5);
    export_fig('../figs/1c1.pdf');

    figure(6);
    export_fig('../figs/1c2.pdf');

    figure(7);
    export_fig('../figs/1d1.pdf');

    figure(8);
    export_fig('../figs/1d2.pdf');

    figure(9);
    export_fig('../figs/1e.pdf');
end


% Get Chebyshev nodes of the first kind and barycentric interpolation weights
function [xc,wc] = chebnodeswgts(n)

xc = cos((2*(0:n-1)'+1)/(2*n)*pi);  % Chebyshev nodes
wc = (-1).^(0:n-1)'.*sin((2*(0:n-1)'+1)/(2*n)*pi); % Barycentric weights

end
