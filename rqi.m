% Rayleigh quotient iteration demo

n = 100;        % Matrix size
niter = 5;      % Number of Rayleigh quotient iterations

rng(184);       % Use a fixed random seed for repeatability
A = rand(n);    % Random symmetric matrix
A = (A+A')/2;

[V,D] = eig(A); D = diag(D);    % Compute vector of eigenvalues

% Initial guess
lambda = rand;
y = rand(n,1);
fprintf('Initial guess: lambda = %.15f\n', lambda);

warning('off', 'MATLAB:nearlySingularMatrix'); % Suppress singular matrix warning

% Rayleigh quotient iteration
for k=1:niter
    y = (A-eye(n)*lambda)\y;
    y = y/norm(y);
    lambda = y.'*(A*y);
    
    % We are finding SOME eigenvalue: compute smallest eigenvalue error
    [err,idx] = min(abs(lambda-D));

    fprintf('Iteration %d: lambda = %.15f, error = %.2e\n', k, lambda, err);
end

% Compute error of eigenvector
evecerr = min(norm(y-V(:,idx)), norm(y+V(:,idx))); % Might converge to evec or -evec
fprintf('Eigenvector error = %.2e\n', evecerr);