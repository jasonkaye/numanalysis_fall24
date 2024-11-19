% Homework 4, Problem 1

plotsettings;
addpath ~/Documents/MATLAB/export_fig/
export = true;

%
%% Part a

n = 100;
Lambda = diag(1./(1:n));                % Eigenvalues 1/k
[U,~] = qr(rand(n));
A = U*Lambda*U.';                       % Random matrix w/ given eigenvalues

lambda_eig = sort(eig(A),'descend');    % Compute eigenvalues using MATLAB's solver

% Print eigenvalue error
fprintf('Max eigenvalue error: %g\n', max(abs(lambda_eig - 1./(1:n).')));

%% Part b

tol = 1e-12;
maxiter = 1000;

% Get leading eigenvector, and make sure sign of first entry is positive
v1 = U(:,1);
if v1(1)<0
    v1 = -v1;
end

% Run power method until convergence to tolerance
x = rand(n,1);
x = x/norm(x);
err = zeros(maxiter,1);
for niter = 1:maxiter
    y = A*x;
    lambda = y.'*x;
    x = y/norm(y);
    if (x(1)<0)   % Make sure sign of first entry is positive
        x = -x;
    end
    err(niter) = norm(x-v1);
    if err(niter)<tol
        fprintf('Power method converged to tolerance %g in %d iterations\n', tol, niter);
        err = err(1:niter);
        break;
    end
end
if niter == maxiter
    fprintf('Power method did not converge to tolerance %g in %d iterations\n', tol, maxiter);
end

figure(1);
semilogy(1:niter,err,'o-'); hold on
semilogy(1:niter,2*(1/2).^(1:niter),'k--'); hold off
ylim([1e-15,1]);
xlabel('Iteration number $k$');
legend('Eigenvector $||\cdot||_2$ error','$\mathcal{O}(1/2^k)$');
set(gca,'fontsize',labelsize)

%% Part c

% Run power method with deflation to compute second eigenvector
v2 = U(:,2);
if v2(1)<0
    v2 = -v2;
end

x = rand(n,1);
x = x - (v1.'*x)*v1; % Project out first eigenvector
x = x/norm(x);
err = zeros(maxiter,1);
for niter = 1:maxiter
    y = A*x;
    lambda = y.'*x;
    y = y - (v1.'*y)*v1;  % Project out first eigenvector
    x = y/norm(y);
    if (x(1)<0)         % Make sure sign of first entry is positive
        x = -x;
    end
    err(niter) = norm(x-v2);
    if err(niter)<tol
        fprintf('Deflated power method converged to tolerance %g in %d iterations\n', tol, niter);
        err = err(1:niter);
        break;
    end
end
if niter == maxiter
    fprintf('Deflated power method did not converge to tolerance %g in %d iterations\n', tol, maxiter);
end

figure(2);
semilogy(1:niter,err,'o-'); hold on
semilogy(1:niter,5*(2/3).^(1:niter),'k--'); hold off
ylim([1e-15,1]);
xlabel('Iteration number $k$');
legend('Eigenvector $||\cdot||_2$ error','$\mathcal{O}((2/3)^k)$');
set(gca,'fontsize',labelsize)

%% Part d

% Run inverse iteration to compute 20th eigenvalue
s = 51/1000;
v20 = U(:,20);
if v20(1)<0
    v20 = -v20;
end

x = rand(n,1);
x = x/norm(x);
err = zeros(maxiter,1);
for niter = 1:maxiter
    y = (A-s*eye(n))\x;
    lambda = 1/(y.'*x) + s;
    x = y/norm(y);
    if (x(1)<0)         % Make sure sign of first entry is positive
        x = -x;
    end
    err(niter) = norm(x-v20);
    if err(niter)<tol
        fprintf('Inverse iteration converged to tolerance %g in %d iterations\n', tol, niter);
        err = err(1:niter);
        break;
    end
end
if niter == maxiter
    fprintf('Inverse iteration did not converge to tolerance %g in %d iterations\n', tol, maxiter);
end

figure(3);
semilogy(1:niter,err,'o-'); hold on
semilogy(1:niter,(19/31).^(1:niter),'k--'); hold off
ylim([1e-15,1]);
xlabel('Iteration number $k$');
legend('Eigenvector $||\cdot||_2$ error','$\mathcal{O}((19/31)^k)$');
set(gca,'fontsize',labelsize)

%% Part e

% Run Rayleigh quotient iteration to compute 20th eigenvalue

% Turn off close to singular matrix warnings
warning('off','MATLAB:nearlySingularMatrix');

x = rand(n,1);
x = x/norm(x);
lambda = s;
err = zeros(maxiter,1);
for niter = 1:maxiter
    y = (A-lambda*eye(n))\x;
    x = y/norm(y);
    lambda = x.'*A*x;
    if (x(1)<0)         % Make sure sign of first entry is positive
        x = -x;
    end
    err(niter) = norm(x-v20);
    if err(niter)<tol
        fprintf('Rayleigh quotient iteration converged to tolerance %g in %d iterations\n', tol, niter);
        err = err(1:niter);
        break;
    end
end
if niter == maxiter
    fprintf('Rayleigh quotient iteration did not converge to tolerance %g in %d iterations\n', tol, maxiter);
end

figure(4);
semilogy(1:niter,err,'o-');
ylim([1e-15,1]);
xlabel('Iteration number $k$');
ylabel('Eigenvector $||\cdot||_2$ error');
set(gca,'fontsize',labelsize)


if export
    figure(1);
    export_fig('../figs/1b.pdf');

    figure(2);
    export_fig('../figs/1c.pdf');

    figure(3);
    export_fig('../figs/1d.pdf');

    figure(4);
    export_fig('../figs/1e.pdf');
end

