% Homework 2, Problem 4

plotsettings;
addpath ../../../../code/functions
export = false;

%% Part c
A = [2,-1,0;-1,2,-1;0,-1,2];
b = [1;0;1];

[L,U] = lu_nopivot(A); % LU factorization
y = forwardsub(L,b);   % Forward substitution
x = backsub(U,y);      % Backward substitution

fprintf('Computed solution for part c:\n');
disp(x);

err = norm(x - [1;1;1]); % l^2 error
fprintf('Error for part c: %g\n', err);

%% Part d
A = [1e-20, 1; 1, 1];
b = [1; 2];

[L,U] = lu_nopivot(A); % LU factorization
y = forwardsub(L,b);   % Forward substitution
x = backsub(U,y);      % Backward substitution

fprintf('Computed solution for part d:\n');
disp(x);

err = norm(x - [1;1]); % l^2 error
fprintf('Error for part d: %g\n', err);

%% Part e
A = 2*rand(1000)-1;
A = A/norm(A);
xtrue = 2*rand(1000,1)-1;
xtrue = xtrue/norm(xtrue);
b = A*xtrue;

[L,U] = lu_nopivot(A); % LU factorization
y = forwardsub(L,b);   % Forward substitution
x = backsub(U,y);      % Backward substitution

err = norm(x - xtrue); % l^2 error
fprintf('Error for part e: %g\n', err);

norm(xtrue-A\b)