% Read the neighbourhood data
% Recover the image
load('data.mat')

% Super-Resolution Image
supername = '1.jpg';
super_rgb = imread(supername);
yiq_super = rgb2ntsc(super_rgb);
super = yiq_super(:,:,1);

% Let go of means
train_patch = patch_up(ytrain, 3);
dst_patch = patch_up(ydst, 3);
[htrain_patch,~] = size(train_patch);
train_mean = getmeans(train_patch);
dst_mean = getmeans(dst_patch);
% for i = 1:1:htrain_patch
%     train_patch(i,:) = train_patch(i,:) - ones(1, 9) * train_mean(i);
% end

stride = 3;
big = 6;
gap = (stride + 1)/2;

% Using the weight to recover
% For every patch in neighbours
% Before everything, insert the value to make a basis of bigger image
yiq = make_train(yiq_dst);
r = ntsc2rgb(yiq);
Y = yiq(:,:,1);
% consider overlap
[tmph, tmpl] = size(Y);
cnt = zeros(tmph, tmpl);
M = zeros(tmph, tmpl);

dstylim = floor((hdst - 1)/2); dstxlim = floor((ldst - 1)/2);
trainylim = floor((htrain - 1)/2); trainxlim = floor((ltrain - 1)/2);
num = 1;
[~,k] = size(neighbours);

for dsty = 1:1:dstylim
    for dstx = 1:1:dstxlim
        
        J = zeros(big, big);
        % calculate the weights
        X_ = dst_patch(num,:)' * ones(1, k);
        X = [];
        for i = 1:1:k
            X = [X, train_patch(neighbours(num,i), :)'];
        end
        G = (X_ - X)' * (X_ - X);
        [gh, gl] = size(G);
        G = G + 0.01 * ones(gh, gl);
        tmpG = inv(G) * ones(k, 1);
        w = tmpG/(ones(1, k) * tmpG);
        %w = [1/5,1/5,1/5,1/5,1/5];
        for i = 1:1:k
            loc = neighbours(num,i);
            y = floor((loc - 1)/trainxlim) + 1;
            x = loc - (y - 1) * trainxlim;
            yloc = 4 * (y - 1) + 1;
            xloc = 4 * (x - 1) + 1;
            adder = super(yloc:yloc-1+big, xloc:xloc-1+big) - ones(6, 6)*train_mean(loc);
            J = J + adder * w(i);
        end
        J = J + ones(6,6) * dst_mean(num);
        num = num + 1;
        ydst = 4 * (dsty - 1) + 1;
        xdst = 4 * (dstx - 1) + 1;
        M(ydst:ydst-1+big, xdst:xdst-1+big) = M(ydst:ydst-1+big, xdst:xdst-1+big) + J;        
        cnt(ydst:ydst-1+big, xdst:xdst-1+big) = cnt(ydst:ydst-1+big, xdst:xdst-1+big) + ones(big,big);
    end
end

for i = 1:1:tmph
    for j = 1:1:tmpl
        Y(i, j) = Y(i, j) * 0.9 + M(i, j)/cnt(i, j) * 0.1;
    end
end
 res = cat(3, Y,yiq(:,:,2),yiq(:,:,3));
 res_rgb = ntsc2rgb(res);
 imwrite(res_rgb,'test.jpg');