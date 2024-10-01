% Homework 1, Problem 1

plotsettings;
addpath ../../../../code/functions
addpath ~/Documents/MATLAB/export_fig/
export = true;

%
%% Part a

f = @(x) besselj(0,2*(x+1));       % Define the function
x = linspace(-1,1,100);     % Get a grid
figure(1);
plot(x,f(x),'.-');
xlabel('$x$');
ylabel('$f(x)$');
title('$f(x) = J_0(x)$');
set(gca,'fontsize',labelsize)

x0 = 0;                     % Initial guess
xtrue = fzero(f, x0)        % Find the root
hold on; plot(xtrue, f(xtrue), 'ro'); hold off  % Plot the root

%% Part b
itermax = 30;                                   % Number of iterations
[xbisect,xiter] = bisection(f, -1, 1, itermax); % Find the root using bisection 
err = abs(xiter - xtrue);                       % Compute error

figure(2);
k = 1:itermax+1;
semilogy(k,err,'.-'); hold on
semilogy(k,2.^(-(k-1)),'r--'); hold off
xlabel('Iteration');
legend('Error','Theoretical bound');
title('Error in Bisection Method');
set(gca,'fontsize',labelsize)

if export
    figure(1);
    export_fig('../figs/1a.pdf');
    figure(2);
    export_fig('../figs/1b.pdf');
end