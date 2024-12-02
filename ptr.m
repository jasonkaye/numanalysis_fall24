% Periodic trapezoid rule demonstration

n = 70;
f = @(x) sin(5*cos(x-1.3798712).^5).^2;

h = 2*pi/n;
x = -pi:h:pi-h;

inttrue = integral(f,-pi,pi,'RelTol',1e-15);
intptr = h*sum(f(x));  % Because f is periodic, trapezoid rule identical to left endpoint rule

fprintf('True integral: %g\n',inttrue)
fprintf('Periodic trapezoid rule: %g\n',intptr)
fprintf('Error: %g\n',abs(inttrue-intptr))

% Plot function on integration grid
figure(1);
plot(x,f(x),'.-')
xlim([-pi,pi])
xlabel('x')
ylabel('f(x)')

% Convergence study
ns = 1:100;
errs = zeros(size(ns));

for i = 1:length(ns)
    n = ns(i);
    h = 2*pi/n;
    x = -pi:h:pi-h;
    errs(i) = abs(inttrue - h*sum(f(x)));
end

figure(2);
semilogy(ns,errs,'.-')
ylim([1e-16,1])
xlabel('n')
ylabel('Error')
title('Convergence of periodic trapezoid rule')

% Now make the function slightly non-periodic and repeat convergence study
g = @(x) sin(5*cos(1.1*x-1.3798712).^5).^2;
inttrue = integral(g,-pi,pi,'RelTol',1e-15);

ns = 2.^(2:16);
errs = zeros(size(ns));

for i = 1:length(ns)
    n = ns(i);
    h = 2*pi/n;
    x = -pi:h:pi;
    errs(i) = abs(inttrue - h*trapz(g(x)));
end

figure(3);
loglog(ns,errs,'.-',ns,0.1./ns.^2,'k--')
ylim([1e-16,1])
xlabel('n')
legend('Error','O(1/n^2)')
title('Convergence of non-periodic trapezoid rule')
