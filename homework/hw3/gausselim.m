% Gaussian elimination for Ax=b with partial pivoting
%
% Inputs
% A         Matrix of linear system
% b         Right-hand side of linear system
%
% Output
% x         Solution of linear system obtained by Gaussian elimination with partial pivoting

function x = gausselim(A,b)

n = length(b);

% Elimination
for j=1:n-1
    [piv,idx] = max(abs(A(j:n,j))); % Find pivot
    idx = idx + j - 1;              % Obtain actual row index of pivot

    if piv == 0
        warning('Matrix is singular; cannot proceed with elimination');
        x = [];
        return;
    end

    % Swap rows of A
    tmprow = A(j,:);
    A(j,:) = A(idx,:);
    A(idx,:) = tmprow;

    % Swap entries of b
    tmpentry = b(j);
    b(j) = b(idx);
    b(idx) = tmpentry;

    % Proceed with elimination
    for i=j+1:n
        c = A(i,j)/A(j,j);
        A(i,j:n) = A(i,j:n) - c*A(j,j:n);
        b(i) = b(i) - c*b(j);
    end
end

x = backsub(A,b); % Solve the upper-triangular system by back substitution

end