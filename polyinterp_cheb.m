% Demo: polynomial interpolation at Chebyshev nodes

addpath functions
plotsettings;

n = 128;                 % Number of interpolation nodes
neval = 1000;            % Evaluation grid

% A few functions to choose from
% f = @(x) sin(2*pi*x);
f = @(x) 1./(1+25*x.^2);
% f = @(x) tan(x);
% f = @(x) exp(cos(300*x).^2);

xc = cos((2*(0:n-1)'+1)/(2*n)*pi);  % Chebyshev interpolation nodes

% Barycentric interpolation weights for Chebyshev nodes
wc = (-1).^(0:n-1)'.*sin((2*(0:n-1)'+1)/(2*n)*pi);

y = f(xc);               % Function values at interpolation nodes

xeval = linspace(a,b,neval).';

p = zeros(neval,1);
for k=1:neval
    p(k) = baryinterp(xeval(k),xc,y,wc);
end

hfig = figure(2);
hfig.Position(3:4) = [1000 600];
subplot(2,1,1)
plot(xeval,f(xeval),'-','Linewidth',4); hold on
plot(xeval,p,'.-')
plot(xc,f(xc),'.r','MarkerSize',20); hold off
legend('True function','Chebyshev interpolant','Data points')
xlabel('$x$')
title('Polynomial interpolation at Chebyshev nodes')
set(gca,'fontsize',labelsize)

subplot(2,1,2)
semilogy(xeval,abs(f(xeval)-p),'.-');
xlabel('$x$')
ylabel('Absolute error')
title('Chebyshev interpolation error')
set(gca,'fontsize',labelsize)