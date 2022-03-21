function out_img = rgb2yiq(img)
%RGB2CMY performs the color change from rgb to cmy
%   Detailed explanation goes here

arguments
    img (:,:,:) uint8
end

I = im2double(img);

M = [0.299  0.587   0.114;
     0.5959 -0.2746 -0.3213;   
     0.2115 -0.5227 0.3112];

for i = [1:size(img,1)]
    for j = [1:size(img,2)]
        R = I(i,j,1);
        G = I(i,j,2);
        B = I(i,j,3);
        result = M*[R;G;B];
        out_img(i,j,1) = result(1);
        out_img(i,j,2) = result(2);
        out_img(i,j,3) = result(3);
    end
end


out_img = uint8(rescale(out_img,0,255));
end

