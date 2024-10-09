% Numerical instability of computing exp(-x) by direct Taylor series evaluation

% First compute Taylor series expansion directly
nterm = 80; % Number of terms of Taylor series to include
x = 20;

fprintf('Computing exp(-%d) by Taylor series with %d terms\n', x, nterm);
term = 1;
ssum = 1;
for k = 1:nterm
    term = -x*term/k;    % Compute next term of series
    ssum = ssum + term;  % Add next term to sum

    fprintf('k = %2d, term = %12.4e, ssum = %12.4e\n', k, term, ssum);

end

fprintf('exp(-%d) = %12.4e\n', x, exp(-x));
fprintf('Computed result = %12.4e\n', ssum);

% Now compute exp(-x) by 1/exp(x)

fprintf('\nComputing exp(-%d) by 1/exp(%d)\n', x, x);
term = 1;
ssum = 1;
for k = 1:nterm
    term = x*term/k;    % Compute next term of series
    ssum = ssum + term; % Add next term to sum

    fprintf('k = %2d, term = %12.4e, ssum = %12.4e\n', k, term, ssum);
end

fprintf('exp(-%d) = %12.4e\n', x, exp(-x));
fprintf('Computed result = %12.4e\n', 1/ssum);
fprintf('Absolute error = %12.4e\n', abs(exp(-x) - 1/ssum));
fprintf('Relative error = %12.4e\n', abs(exp(-x) - 1/ssum)/exp(-x));