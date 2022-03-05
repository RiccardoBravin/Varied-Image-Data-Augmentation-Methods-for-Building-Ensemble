
%return a n*m*3 image on grayscale
function [gray_image] = to_gray(image)
 im = rgb2gray(image);
 %need to resize the image
 gray_image = im(:,:,[1 1 1]);
end

