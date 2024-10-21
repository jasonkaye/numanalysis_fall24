% Solve upper-triangular system Ux=b by backward substitution
%
% Inputs
% U         Upper-triangular matrix
% b         Right-hand side vector
%
% Output
% x         Solution vector

function x = backsub(U,b)

n = length(b);
x = zeros(n,1);

for i=n:-1:1
    x(i) = (b(i) - U(i,i+1:n)*x(i+1:n))/U(i,i);
end

end