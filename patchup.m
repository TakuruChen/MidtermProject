% patch the metrix M up
% with size n * n
function J = patchup(M, n)

[height, length] = size(M);
% the length of each feature
len = n * n;
% the limit of our iterations
iterh = height - n + 1;
iterl = length - n + 1;
% how much superimposing space
gap = fix(n / 2);
% allocate the place to avoid slowing down
J = zeros(ceil(iterh/gap) * ceil(iterl/gap), len);
% count the number of features
num = 1;
for i = 1:gap:iterh
    for j = 1:gap:iterl
        % make the feature --> metrix into a row vector
        feature = reshape(M(i:i+n-1, j:j+n-1), 1, len);
        % add it to right place
        J(num, :) = feature;
        num = num + 1;
    end
end
% get J
J = J(1:num - 1, :);
        
