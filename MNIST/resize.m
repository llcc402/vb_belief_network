images = loadMNISTImages('train-images.idx3-ubyte');
images = images(:,1:1000);
img = zeros(64,1000);
for i = 1:1000
    ig = images(:,i);
    igg = zeros(28);
    for j = 1:28
        igg(:,j) = ig((j-1)*28 + 1: (j-1)*28 + 28);
    end
    igg = imresize(igg, [8 8]);
    for j = 1:8
        img((j-1)*8+1:(j-1)*8+8, i) = igg(:,j);
    end
end

img(img > 0.4) = 1;
img(img <= 0.4) = 0;

data = img';

clear i ig igg images j img
