function J = derivative(M, dir)
% M is the input metrix, dir is the direction
% "1" means horizontal, "0" means vertical

% get the length and the length of the metrix
[height, length] = size(M);

% horizontal
% using the upper row minus the lower row
if dir == 1
    J = zeros(height - 1, length);
    for i = 1:1:(height - 1)
        J(i,:) = M(i,:) - M(i + 1,:);
    end
% vertical
% using the left column minus the right column
else
    J = zeros(height, length - 1);
    for i = 1:1:(length - 1)
        J(:,i) = M(:,i) - M(:,i + 1);
    end
end
    
    
    
