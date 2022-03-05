function [elastic_im] = elastic_deformation(img)
img = rgb2gray(img);

% Normalizing the field
sig=0.5; %media
alpha=90; %scaling factor

% Compute a random displacement field
dx = -1 + 2*rand(size(img)); % dx ~ U(-1,1)
dy = -1 + 2*rand(size(img)); % dy ~ U(-1,1)

nx = norm(dx);
ny = norm(dy);

dx = dx./nx; % Normalization: norm(dx) = 1
dy = dy./ny; % Normalization: norm(dy) = 1

fdx = imgaussfilt(dx,sig,'FilterSize',1); % 2-D Gaussian filtering of dx
fdy = imgaussfilt(dy,sig,'FilterSize',1); % 2-D Gaussian filtering of dy

fdx = alpha*fdx; % Scaling the filtered field
fdy = alpha*fdy; % Scaling the filtered field
%the resulting displacement

[x, y]=ndgrid(1:size(img,1),1:size(img,2));
figure;
imagesc(img); colormap gray; axis image; axis tight;
hold on;
quiver(x,y,fdx,fdy,0,'r');
% Applying the displacement to the original pixels
new = griddata(x-fdx,y-fdy,double(img),x,y);
new(isnan(new)) = 0;
% The resulting digit
new = new(:,:,[1 1 1]);

elastic_im = uint8(new);

end

