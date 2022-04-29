disp("Cascade of all augmentation methods")

fprintf("\t");
DCT;
% imshow(training_imgs(:,:,:,end));
% pause(0.5);

fprintf("\t");
Deformation;
% imshow(training_imgs(:,:,:,end));
% pause(0.5);

fprintf("\t");
FFT;
% imshow(training_imgs(:,:,:,end));
% pause(0.5);

fprintf("\t");
FFTCombine;
% imshow(training_imgs(:,:,:,end));
% pause(0.5);

fprintf("\t");
Laplacian;
% imshow(training_imgs(:,:,:,end));
% pause(0.5);

fprintf("\t");
SingValDec;
% imshow(training_imgs(:,:,:,end));
% pause(0.5);

fprintf("\t");
SuperPixel;
% imshow(training_imgs(:,:,:,end));
% pause(0.5);

fprintf("\t");
ColorReduction
% imshow(training_imgs(:,:,:,end));
% pause(0.5);

fprintf("\t");
HilbertTransform;
% imshow(training_imgs(:,:,:,end));
% pause(0.5);