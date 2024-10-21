% Homework 3, Problem 1

plotsettings;
addpath ~/Documents/MATLAB/export_fig/
export = true;

%
%% Part b
A = [1e-20, 1; 1, 1];
b = [1; 2];

x = gausselim(A,b);

fprintf('Computed solution for first system:\n');
disp(x);

err = norm(x - [1;1]); % l^2 error
fprintf('Error for first system: %g\n', err);

A = 2*rand(1000)-1;
A = A/norm(A);
xtrue = 2*rand(1000,1)-1;
xtrue = xtrue/norm(xtrue);
b = A*xtrue;

x = gausselim(A,b);

err = norm(x - xtrue); % l^2 error
fprintf('Error for second system: %g\n', err);

%% Part c: Hilbert matrix example

ns = 2:15;
kappas = zeros(length(ns),1);
errors = zeros(length(ns),1);
residuals = zeros(length(ns),1);
for k = 1:length(ns)
    n = ns(k);

    % Form Hilbert matrix and right hand side b
    H = zeros(n);
    b = zeros(n,1);
    for i = 1:n
        for j = 1:n
            H(i,j) = 1/(i+j-1);
            b(i) = b(i) + H(i,j);
        end
    end

    % Solve system
    x = gausselim(H,b);

    % Compute condition number of H
    kappas(k) = cond(H);

    % Compute relative error and relative residual
    errors(k) = norm(x - ones(n,1))/norm(x);
    residuals(k) = norm(b - H*x)/norm(b);

end

figure(1);
semilogy(ns,errors,'o-'); hold on
semilogy(ns,eps*kappas,'k--');
semilogy(ns,residuals,'x-'); hold off
xlabel('$n$');
legend('Relative error','$\kappa(H_n) \epsilon$','Relative residual','Location','NorthWest');
title('Hilbert matrix linear solve errors');
set(gca,'fontsize',labelsize)

%% Part d: Wilkinson's matrix

n = 100;
A = tril(-ones(n)) + 2*eye(n); A(:,end) = 1;
%A(:,end) = A(:,end) + 1e-15*randn(n,1);

xtrue = randn(n,1);
b = A*xtrue;
x = gausselim(A,b);

fprintf('Condition number of Wilkinson''s matrix: %g\n', cond(A));
fprintf('Relative error of linear solve: %g\n', norm(x - xtrue)/norm(xtrue));
fprintf('Relative residual of linear solve: %g\n', norm(b - A*x)/norm(b));

%% Part d: Gaussian elimination timing

ns = 2.^(5:10);
times = zeros(length(ns),1);

for k = 1:length(ns)
    n = ns(k);
    A = rand(n);
    b = rand(n,1);

    tic;
    x = gausselim(A,b);
    times(k) = toc;
end

figure(2);
loglog(ns,times,'o-',ns,1e-7*ns.^3,'--k');
xlabel('$n$');
legend('Wall clock time (s)', '$\mathcal{O}(n^3)$','Location','NorthWest');
title('Gaussian elimination timing');
set(gca,'fontsize',labelsize)

if export
    figure(1);
    export_fig('../figs/1c.pdf');

    figure(2);
    export_fig('../figs/1e.pdf');
end