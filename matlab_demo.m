% Simple MATLAB demo
%
% From Lecture 1

%% Linear Algebra

v = [1;2;3];    % Make a vector
A = rand(3,3);  % Random 3x3 matrix
y = A*v         % Matrix-vector product
B = rand(4,3);  % Random 4x3 matrix
C = B*A;        % Matrix-matrix product

b = rand(3,1);  % Solve a linear system Ax=b
x = A\b

[U,S,V] = svd(A);   % Compute an SVD


%% Nonlinear solvers (f(x) = 0)

f = @(x) exp(-x).*cos(x);   % Define a function handle
x = linspace(-10,10,1000);  % Get an equispaced grid of points

figure(1);
plot(x,f(x),'.-'); hold on  % Plot the function

% Find a zero of the function
x0 = -9;            % Initial guess
x0 = fzero(f,x0);   % Find a zero

plot(x0,f(x0),'o'); hold off    % Plot the zero
f(x0)                           % Verify f(x)~=0

%% Plot a special function
x = linspace(0,100,1000);   % Get a grid
J0 = besselj(0,x);          % Evaluate a Bessel function on the grid

figure(2);
plot(x,J0,'.-')             % Plot it

%% Plotting algebraic growth

x = linspace(0,5,100);
y = 2*x.^2 + 0.1*rand(size(x)) + 0.3;   % Noisy data w/ quadratic growth

figure(3);
subplot(2,1,1);
plot(x,y,'.-');                  % Ordinary plot
subplot(2,1,2);
loglog(x,y,'.-',x,x.^2,'--k');   % Straight line on a loglog plot

%% Plotting exponential growth

y = 2.^x - 1.4 + 0.3*rand(size(x)); % Noisy data w/ exponential growth

figure(4);
subplot(2,1,1);
plot(x,y,'.-');                      % Ordinary plot
subplot(2,1,2);
semilogy(x,y,'.-',x,2.^x,'--k');     % Straight line on a lin-log plot



