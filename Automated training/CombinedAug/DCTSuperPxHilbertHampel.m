disp("Cascade of all augmentation methods")

fprintf("\t");
DCT;
% imshow(training_imgs(:,:,:,end));
% pause(0.5);

fprintf("\t");
SuperPixel;
% imshow(training_imgs(:,:,:,end));
% pause(0.5);

fprintf("\t");
HilbertTransform;
% imshow(training_imgs(:,:,:,end));
% pause(0.5);

fprintf("\t");
Hampel;
% imshow(training_imgs(:,:,:,end));
% pause(0.5);
