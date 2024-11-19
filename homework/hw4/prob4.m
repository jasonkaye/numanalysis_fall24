% Homework 4, Problem 4

plotsettings;
addpath ~/Documents/MATLAB/export_fig/
export = true;

%
%% Part b

n = 1000;
Lambda1 = diag(1+(4-1)*rand(n,1));    % Random eigenvalues in [1,4] 
Lambda2 = diag(1+(100-1)*rand(n,1));  % Random eigenvalues in [1,100] 
[U,~] = qr(rand(n));
A1 = U*Lambda1*U.';                   % Random matrices w/ given eigenvalues
A2 = U*Lambda2*U.';

b = rand(n,1);                        % Random right-hand side
b = b/norm(b);

tol = 1e-12;
maxiter = 1000;

[x1,errs1] = mycg(A1,b,zeros(n,1),tol,maxiter);
[x2,errs2] = mycg(A2,b,zeros(n,1),tol,maxiter);

% Verify solution is correct
fprintf('Error in solution to first system compared to backslash: %e\n',norm(x1-A1\b));
fprintf('Error in solution to second system compared to backslash: %e\n',norm(x2-A2\b));

% Plot errors
myfig = figure(1);
myfig.Position = [100,100,800,600];
semilogy(1:length(errs1),errs1,'o-',1:length(errs2),errs2,'x-'); hold on
semilogy(1:length(errs1),10*(1/3).^(1:length(errs1)),'k-.');
semilogy(1:length(errs2),(9/11).^(1:length(errs2)),'k--'); hold off
xlabel('Iteration number $k$');
ylabel('Estimated error $||x_k-x_{k-1}||_A$');
legend('Eigenvalues in $[1,4]$','Eigenvalues in $[1,100]$','$\mathcal{O}((1/3)^k)$','$\mathcal{O}((9/11)^k)$');
set(gca,'fontsize',labelsize)


if export
    figure(1);
    export_fig('../figs/4b.pdf');
end

