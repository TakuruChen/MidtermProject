% read in the picture and get the luminorsity metrix
rgb = imread('D:\大二下\算法设计与分析\project\Neighbour Embedding\pics\1.jpg');  % read in the picture
yiq = rgb2ntsc(rgb);         % tranfer to yiq
y = yiq(:,:,1);              % get the metrix of luminorsity
[height, length] = size(y);  % get the size of the picture

% calculate the 1-derivative of the picture (metrix y)
% horizontal and vertical
dev_one_horizontal = derivative(y, 1);
dev_one_vertical = derivative(y, 0);

% calculate the 2-derivative of the picture
% horizontal and vertical
dev_two_horizontal = derivative(dev_one_horizontal, 1);
dev_two_vertical = derivative(dev_one_vertical, 0);

%fprintf('Derivate of this picture has cpmpleted\n');

% calculate the features
feature_1_horizontal = patchup(dev_one_horizontal, 5);
% fprintf('Derivate of this 1-horizontal has cpmpleted\n');
feature_1_vertical = patchup(dev_one_vertical, 5);
% fprintf('Derivate of this 1-vertical has cpmpleted\n');
feature_2_horizontal = patchup(dev_two_horizontal, 5);
% fprintf('Derivate of this 2-horizontal has cpmpleted\n');
feature_2_vertical = patchup(dev_one_vertical, 5);
% fprintf('Derivate of this 2-vertical has completed\n');
