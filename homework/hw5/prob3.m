% Homework 5, Problem 3

plotsettings;
addpath ~/Documents/MATLAB/export_fig/
export = false;

neval = 1000;         % Evaluation grid
xeval = linspace(-1,1,neval)';
    
f = @(x) exp(-x.^2);

ns = 2:5:40;
[fevalexp,fevalbary] = deal(zeros(neval,1));
[errexp,errbary] = deal(zeros(size(ns)));
for k=1:length(ns)
    n = ns(k);
    
    % Get Chebyshev nodes
    [xc,wc] = chebnodeswgts(n);

    % Form Chebyshev Vandermonde matrix
    T = cos(((0:n-1)'+1/2)*(0:n-1)*pi/n);

    % Evaluate function at Chebyshev nodes
    fxc = f(xc);

    % Obtain Chebyshev coefficients
    c = T\fxc;

    % Evaluate Chebyshev expansion and barycentric interpolant at evaluation nodes
    for i=1:neval
        fevalexp(i) = evalcheb(xeval(i),c);
        fevalbary(i) = baryinterp(xeval(i),xc,fxc,wc);
    end

    % Compute maximum absolute error

    errexp(k) = max(abs(fevalexp-f(xeval)));
    errbary(k) = max(abs(fevalbary-f(xeval)));
end

figure(1);
semilogy(ns,errexp,'.-',ns,errbary,'.-')
xlabel('Number of Chebyshev nodes')
ylabel('Maximum absolute error')
legend('Chebyshev expansion','Barycentric interpolation')
set(gca,'fontsize',labelsize)


if export
    figure(1);
    export_fig('../figs/3b.pdf');
end

% Get Chebyshev nodes of the first kind and barycentric interpolation weights
function [xc,wc] = chebnodeswgts(n)

xc = cos((2*(0:n-1)'+1)/(2*n)*pi);  % Chebyshev nodes
wc = (-1).^(0:n-1)'.*sin((2*(0:n-1)'+1)/(2*n)*pi); % Barycentric weights

end

