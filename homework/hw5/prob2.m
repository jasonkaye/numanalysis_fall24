% Homework 5, Problem 2

plotsettings;
addpath ~/Documents/MATLAB/export_fig/
export = false;

%% Part a

ns = 2:5:40;

Vcond = zeros(size(ns));
for i=1:length(ns)

    % Form Vandermonde matrix
    n = ns(i);
    x = linspace(-1,1,n)';
    V = zeros(n,n);
    for j=1:n
        V(:,j) = x.^(j-1);
    end
    Vcond(i) = cond(V);

end


figure(1);
semilogy(ns,Vcond,'.-')
xlabel('$n$')
ylabel('Condition number')
set(gca,'fontsize',labelsize)


%% Part b

ns = [10,500,1000];

Tcond = zeros(size(ns));
for i=1:length(ns)

    % Form Chebyshev Vandermonde matrix
    n = ns(i);
    T = cos(((0:n-1)'+1/2)*(0:n-1)*pi/n);
    fprintf('n = %d, cond(T) = %e\n',n,cond(T));

end


if export
    figure(1);
    export_fig('../figs/2a.pdf');
end