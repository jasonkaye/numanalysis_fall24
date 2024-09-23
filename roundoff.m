% Simple demonstration of roundoff error accumulation

niter = 60;
x0 = 0.1;   % 0.1 is rounded in base 2

x = x0;
for k=1:niter
    fprintf('k=%d, x=%0.18f\n', k, x);
    if (0<=x && x<=0.5)
        x = 2*x;
    else
        x = 2*x - 1;
    end
end