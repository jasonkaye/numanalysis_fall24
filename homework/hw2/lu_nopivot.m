% LU factorization without pivoting
%
% Inputs
% A         Square matrix
%
% Output
% L         Lower triangular matrix L in A = LU
% U         Upper triangular matrix L in A = LU
%
% Warning: Since this function does not use pivoting, it may fail to produce accurate results.

function [L,U] = lu_nopivot(A)

n = length(A);

% Elimination
for j=1:n-1
    for i=j+1:n
        c = A(i,j)/A(j,j);
        A(i,j:n) = A(i,j:n) - c*A(j,j:n);
        A(i,j) = c;
    end
end

L = tril(A,-1) + eye(n);
U = triu(A);            

end