% Rayleigh quotient iteration with deflation to compute all eigenvalues of a
% matrix
% Inputs:
%  A: matrix
%  tol: tolerance
%  maxiter: maximum number of iterations
% Outputs:
%  V: matrix of eigenvectors
%  D: vector of eigenvalues
function [V,D] = rqi_deflation(A,tol,maxiter)
    n = size(A,1);
    V = zeros(n,n);
    D = zeros(n,1);
    for i = 1:n
        x = rand(n,1);          % Random initial guess for ith eigenvector
        x = x - (V(:,1:i)*(V(:,1:i).'*x)); % Deflation: orthogonalize against previous eigenvectors
        x = x/norm(x);          % Normalize 
        lambda = 0;             % Initial guess for ith eigenvalue
        for niter = 1:maxiter   % Rayleigh quotient iteration for ith eigenvalue
            y = (A-lambda*eye(n))\x;
            y = y - (V(:,1:i)*(V(:,1:i).'*y)); % Orthogonalize against previous eigenvectors
            xnew = y/norm(y);
            lambda = x.'*A*x;
            if (xnew(1)<0)      % Make sure sign of first entry is positive
                xnew = -xnew;
            end
            err = norm(xnew-x); % Error estimate
            x = xnew;
            if err < tol
                break;
            end
        end
        if niter == maxiter
            fprintf('Rayleigh quotient iteration did not converge to tolerance %g in %d iterations\n for eigenvalue %d', tol, maxiter, i);
        end
        V(:,i) = x;
        D(i) = lambda;
    end
end