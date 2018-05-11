% First, read in the training mage with lower resolution
train_name = 't1.jpg';
rgb_train = imread(train_name);
yiq_train = rgb2ntsc(rgb_train);
ytrain = yiq_train(:,:,1);
[htrain, ltrain] = size(ytrain);

% Next, read in the image to be enhanced
dst_name = 'sp.jpg';
rgb_dst = imread(dst_name);
yiq_dst = rgb2ntsc(rgb_dst);
ydst = yiq_dst(:,:,1);
[hdst, ldst] = size(ydst);

% Calculate the feature of the training image
% set patch size to 3*3
% Caiculate the derivative first
dev1_train_h = derivative(ytrain, 1);
dev1_train_v = derivative(ytrain, 0);
dev1_train_h = [0.1 * dev1_train_h(1,:);dev1_train_h];
dev1_train_v = [0.1 * dev1_train_v(:,1),dev1_train_v];
dev2_train_h = derivative(dev1_train_h, 1);
dev2_train_v = derivative(dev1_train_v, 0);
dev2_train_h = [0.1 * dev2_train_h(1,:);dev2_train_h];
dev2_train_v = [0.1 * dev2_train_v(:,1),dev2_train_v];

% Make the feature vector
feature1 = patch_up(dev1_train_h, 3);
feature2 = patch_up(dev1_train_v, 3);
feature3 = patch_up(dev2_train_h, 3);
feature4 = patch_up(dev2_train_v, 3);
feature_train = [feature1, feature2, feature3, feature4];

% Calculate the feature of the raw image
% set patch size to 3*3
% Caiculate the derivative first
dev1_train_h = derivative(ydst, 1);
dev1_train_v = derivative(ydst, 0);
dev1_train_h = [0.1 * dev1_train_h(1,:);dev1_train_h];
dev1_train_v = [0.1 * dev1_train_v(:,1),dev1_train_v];
dev2_train_h = derivative(dev1_train_h, 1);
dev2_train_v = derivative(dev1_train_v, 0);
dev2_train_h = [0.1 * dev2_train_h(1,:);dev2_train_h];
dev2_train_v = [0.1 * dev2_train_v(:,1),dev2_train_v];

% Make the feature vector
feature1 = patch_up(dev1_train_h, 3);
feature2 = patch_up(dev1_train_v, 3);
feature3 = patch_up(dev2_train_h, 3);
feature4 = patch_up(dev2_train_v, 3);
feature_dst = [feature1, feature2, feature3, feature4];

clear dev1_train_h; clear dev1_train_v; 
clear dev2_train_h; clear dev2_train_v;
clear feature1; clear feature2;
clear feature3; clear feature4;

save('feature.mat')
