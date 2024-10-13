% Homework 2, Problem 3

plotsettings;
addpath ../../../../code/functions
addpath ~/Documents/MATLAB/export_fig/
export = false;

%% Part d
f = @(x) x.^3 - 2*x.^2 + 3*x - 4;
fp = @(x) 3*x.^2 - 4*x + 3;
fpp = @(x) 6*x - 4;
fp1 = fp(1);
x = 1;

hs = logspace(-1,-16,16);
err = zeros(size(hs));
for i=1:length(hs)
    h = hs(i);
    err(i) = abs(fp1 - finitediff(f,x,h));
end

figure(1);
loglog(hs,err,'-o'); hold on
loglog(hs,abs(fpp(1)/2*hs),'--k');
loglog(hs,abs(2*eps*f(1)./hs),'--r'); hold off
xlabel('$h$'); ylabel('Absolute error');
legend('True error', 'Expected discretization error', 'Expected rounding error');
title('Error of $f''(1)$ using 1st-order finite difference method');
set(gca,'fontsize',labelsize);

%% Part h
d = [0;1;2;3];      % Vector yielding f'(1) for cubic polynomial f
v = [-4;3;-2;1];    % Vector representing f(x) = -4 + 3x - 2x^2 + x^3
abs(d.'*v - fp(1))
abs(d.'*(v+eps*rand(4,1)) - fp(1))

    


if export
    figure(1);
    export_fig('../figs/3d.pdf');
end

% Approximate f'(x) using first-order finite difference method
function fp = finitediff(f, x, h)
    fp = (f(x+h) - f(x))/h;
end