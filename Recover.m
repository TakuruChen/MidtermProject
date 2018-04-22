% Read the neighbourhood data
% Recover the image
load('data.mat')

% Super-Resolution Image
supername = '2.jpg';
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

dsty = 1; dstx = 1;
dstylim = hdst/2 -1; dstxlim = ldst/2 - 1;
trainylim = htrain/2 - 1; trainxlim = ltrain/2 - 1;
num = 1;
cnt = 0;
[~,k] = size(neighbours);

for dsty = 1:1:dstylim
    for dstx = 1:1:dstxlim
        
        J = zeros(6, 6);
        % calculate the weights
        X_ = dst_patch(num,:)' * ones(1, k);
        X = [];
        for i = 1:1:k
            X = [X, train_patch(neighbours(num,i), :)'];
        end
        G = (X_ - X)' * (X_ - X);
        tmpG = inv(G) * ones(k, 1);
        w = tmpG/(ones(1, k) * tmpG);
        % w = [1/5,1/5,1/5,1/5,1/5];
        for i = 1:1:k
            if w(i) < 0||w(i) > 1
                cnt = cnt + 1;
            end
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
        Y(ydst:ydst-1+big, xdst:xdst-1+big) = Y(ydst:ydst-1+big, xdst:xdst-1+big) * 0.8 + J * 0.2;        
        
    end
end
 res = cat(3, Y,yiq(:,:,2),yiq(:,:,3));
 res_rgb = ntsc2rgb(res);