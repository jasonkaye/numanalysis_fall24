% Conjugate gradient method for solving Ax = b
% Inputs:
%  A: matrix
%  b: right-hand side
%  x0: initial guess
%  tol: tolerance in A-norm
%  maxit: maximum number of iterations
%
% Outputs:
%  x: computed solution
%  errs: error in A-norm at each iteration
%
% Note: A must be symmetric positive definite
function [x,errs] = mycg(A,b,x0,tol,maxit)

r = b - A*x0;
p = r;
x = x0;

errs = zeros(maxit,1);
for i = 1:maxit
    Ap = A*p;
    pp = p.'*Ap;
    c = (r.'*p)/pp;
    xnew = x + c*p;
    r = r - c*Ap;
    p = r - ((r.'*Ap)/pp)*p;
    errs(i) = sqrt((xnew-x).'*A*(xnew-x));
    x = xnew;
    if errs(i) < tol
        errs = errs(1:i);
        fprintf('CG method converged to tolerance %e after %d iterations\n',tol,i);
        return;
    end
end
if i == maxit
    fprintf('CG method did not converge to tolerance %e after %d iterations\n',tol,maxit);
end

end

