function J = getmeans(X)
[h, ~] = size(X);
J = zeros(h, 1);
for i = 1:1:h
    J(i) = mean(X(i,:));
end