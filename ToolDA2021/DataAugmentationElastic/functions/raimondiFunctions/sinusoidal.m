%perform a sinusoidal transformation of an RGB img with an amplitude of a
%Output is the created image
function [I_sinusoid] = sinusoidal(img, a)
ifcn = @(xy) [xy(:,1), xy(:,2) + a*sin(2*pi*xy(:,1)/130)]; %define the transform type
tform = geometricTransform2d(ifcn); %apply the transform type
new = imwarp(img,tform,'FillValues',255);
targetSize = [195, 220];
r = centerCropWindow2d(size(new),targetSize);
new = imcrop(new, r); %cut the white spaces
new = imresize(new, [227, 227]); %resize to make it compatible to alex net
I_sinusoid = uint8(new);
end

