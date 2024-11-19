% Homework 4, Problem 2

plotsettings;
addpath ~/Documents/MATLAB/export_fig/
export = true;

%
%% Part a

n = 100;
Lambda = diag(1./(1:n));                % Eigenvalues 1/k
[U,~] = qr(rand(n));
A = U*Lambda*U.';                       % Random matrix w/ given eigenvalues

tol = 1e-12;
maxiter = 100;
[V,D] = rqi_deflation(A,tol,maxiter);

% Plot errors of computed eigenvalues
D = sort(D,'descend');
figure(1);
semilogy(1:n,abs(D-1./(1:n).'),'o-');
ylim([1e-18,1]);
xlabel('Eigenvalue number $i$');
ylabel('Error $|\lambda_i - 1/i|$');
set(gca,'fontsize',labelsize)

if export
    figure(1);
    export_fig('../figs/2b.pdf');

end

