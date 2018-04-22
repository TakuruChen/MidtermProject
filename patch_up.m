% patch the matrix M up
% with size n * n
function J = patch_up(M, n)

[height, length] = size(M);
% the length of each feature
len = n * n;
% how much superimposing space
gap = (n - 1)/2;
% the limit of our iterations
iterh = height - gap;
iterl = length - gap;
% allocate the place to avoid slowing down
J = zeros(floor(iterh/(gap+1)) * floor(iterl/(gap+1)), len);
num = 1;
for i = gap+1:gap+1:iterh
    for j = gap+1:gap+1:iterl
        % make the feature --> metrix into a row vector
        feature = reshape(M(i-gap:i+gap, j-gap:j+gap), 1, len);
        % add it to right place
        J(num, :) = feature;
        num = num + 1;
    end
end