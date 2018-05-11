real = imread('p.jpg');
res = imread('test.jpg');
peaksnr = psnr(real, res);
