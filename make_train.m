% make the image of yiq or rgb 
% 2*2 the size as before
function rgb = make_train(ori)
R = ori(:,:,1);              % get the metrix of luminorsity
G = ori(:,:,2);
B = ori(:,:,3);
[height, length] = size(R);  % get the size of the picture

r1 = zeros(height*2, length*2);
g1 = zeros(height*2, length*2);
b1 = zeros(height*2, length*2);

for i = 1:1:height - 1
    for j = 1:1:length - 1
        for k1 = 0:1:1
            for k2 = 0:1:1
                r1(2*i-1+k1,2*j-1+k2) = (R(i,j) + R(i+k1,j+k2))/2;
                g1(2*i-1+k1,2*j-1+k2) = (G(i,j) + G(i+k1,j+k2))/2;
                b1(2*i-1+k1,2*j-1+k2) = (B(i,j) + B(i+k1,j+k2))/2;
            end
        end
    end
end
for k1 = 0:1:1
    for k2 = 0:1:1
        r1(2*height-k1,2*length-k2) = R(height,length);
        g1(2*height-k1,2*length-k2) = G(height,length);
        b1(2*height-k1,2*length-k2) = B(height,length);
    end
end
rgb = cat(3,r1, g1, b1);