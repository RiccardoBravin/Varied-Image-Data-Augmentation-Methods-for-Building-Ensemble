function [recombinedRGBImage] = elastic_deformationKU(img,alpha)
% Extract color channels.
redChannel = img(:,:,1); % Red channel
greenChannel = img(:,:,2); % Green channel
blueChannel = img(:,:,3); % Blue channel
% Compute a random displacement field
dx = -1+2*rand(size(redChannel));
dy = -1+2*rand(size(redChannel));
% Smoothing the field
sig=4; % Standard deviation of Gaussian convolution
%alpha -> Scaling factor
H=fspecial('gauss',[7 7], sig);
fdx=imfilter(dx,H);
fdy=imfilter(dy,H);
% Normalizing the field
n=sum((fdx(:).^2+fdy(:).^2));
% Scaling the filtered field
fdx=alpha*fdx./n;
fdy=alpha*fdy./n;
% The resulting displacement
[y, x]=ndgrid(1:size(img,1),1:size(img,2));
% Applying the displacement to the original pixels for all color channels
red = griddata(x-fdx,y-fdy,double(redChannel),x,y);
green = griddata(x-fdx,y-fdy,double(greenChannel),x,y);
blue = griddata(x-fdx,y-fdy,double(blueChannel),x,y);
% Recombining the original images in rbg format
recombinedRGBImage = round((cat(3, red, green, blue)));
recombinedRGBImage(isnan(recombinedRGBImage))=0;
recombinedRGBImage=uint8(recombinedRGBImage);
end