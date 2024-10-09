% Line of best fit via least squares fitting

plotsettings;

f = @(x) 1+x;       % Define function from which to generate data

ndata = 100;                                % # data points
xdata = rand(ndata,1);                      % Random points on [0,1]
fdata = f(xdata) + 0.05*randn(ndata,1);     % Generate noisy data

figure(1);
plot(xdata,fdata,'o'); hold on              % Plot the data

A = [ones(ndata,1), xdata];                 % Set up overdetermined matrix
[Q,R] = qr(A);                              % QR decomposition

coefs = R\(Q.'*fdata);                      % Least squares solution

x = linspace(0,1,1000).';                   % Plotting grid
ffit = [ones(1000,1), x]*coefs;             % Evaluate the fit
plot(x,ffit,'.-'); hold off                 % Plot the fit
xlabel('x')
legend('Data','Best fit line');
set(gca, 'FontSize', labelsize)
