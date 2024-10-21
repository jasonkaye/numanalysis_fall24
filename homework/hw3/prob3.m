% Homework 3, Problem 3

plotsettings;
addpath ~/Documents/MATLAB/export_fig/
export = true;

%
%% Part b

f = @(x) cos(sin(x)).^3;    % Function to approximate
ndata = 500;                % Number of data points

xdata = 2*pi*rand(ndata,1).'';          % Random x values on [0,2*pi]
fdata = f(xdata) + 0.05*randn(ndata,1); % Noisy data

% Form matrix of overdetermined system
nmode = 10;                     % Number of cosine modes
A = cos(xdata.*(0:nmode-1));    % Matrix of overdetermined system
[Q,R] = qr(A);                  % QR factorization
coefs = R\(Q.'*fdata);          % Coefficients of least squares fit

nplot = 1000;                    % Number of points in fine grid for plotting
x = linspace(0,2*pi,nplot).';    % Fine grid for plotting
ffit = cos(x*(0:nmode-1))*coefs; % Compute cosine expansion fit on fine grid

fprintf('Maximum error of fit: %g\n', max(abs(f(x) - ffit)));

figure(1);
plot(xdata,fdata,'o',x,ffit,'.-',x,f(x),'--k','LineWidth',2);
xlabel('x');
legend('Noisy data','Fit','$f(x) = \cos^3(\sin(x))$','Location','SouthEast');
title('Least squares fit of $\cos^3(\sin(x))$ + noise');
set(gca,'fontsize',labelsize)

if export
    figure(1);
    export_fig('../figs/3b.pdf');
end