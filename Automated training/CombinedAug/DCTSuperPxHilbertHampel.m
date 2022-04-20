disp("Cascade of all augmentation methods")

DCT;
imshow(training_imgs(:,:,:,end));
pause(0.5);

SuperPixel;
imshow(training_imgs(:,:,:,end));
pause(0.5);

HilbertTransform;
imshow(training_imgs(:,:,:,end));
pause(0.5);

Hampel;
imshow(training_imgs(:,:,:,end));
pause(0.5);
