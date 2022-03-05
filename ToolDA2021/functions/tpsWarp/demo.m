%xGrid is the number of distance between consecutive perturbed pixels in
%the x axis
%yGrid is the number of distance between consecutive perturbed pixels in
%the y axis
%xNoise is the size of the random perturbation in th x axis
%yNoise is the size of the random perturbation in th y axis
%I actually don't know exactly what maxChange stands for.
%it seems we get a more natural image if we use small grids.


% IM1 = imread('samples\first.jpg');
% IM2 = imread('samples\second.jpg');
% IM3 = imread('samples\third.jpg');

IM1 = imresize(IM1,[227,227]);
IM2 = imresize(IM2,[227,227]);
IM3 = imresize(IM3,[227,227]);

xGrid = 8;
yGrid = 10;
xNoise = 4;
yNoise = 5;
maxChange = 8;
%newIM1 = changeImage(IM1, xGrid, yGrid, xNoise, yNoise, maxChange);
newIM1 = changeImage2(IM1, xGrid, yGrid, maxChange, 0.4);
newIM2 = changeImage2(IM2, xGrid, yGrid, maxChange, 0.4);
newIM3 = changeImage2(IM3, xGrid, yGrid, maxChange, 0.4);

xGrid = 10;
yGrid = 5;
xNoise = 8;
yNoise = 6;
maxChange = 20;
%newIM2 = changeImage(IM2, xGrid, yGrid, xNoise, yNoise, maxChange);

xGrid = 24;
yGrid = 18;
xNoise = 16;
yNoise = 16;
maxChange = 40;
%newIM3 = changeImage(IM3, xGrid, yGrid, xNoise, yNoise, maxChange);

newIM1 = changeImage2(IM1, xGrid, yGrid, maxChange, 0.4);
newIM2 = changeImage2(IM2, xGrid, yGrid, maxChange, 0.4);
newIM3 = changeImage2(IM3, xGrid, yGrid, maxChange, 0.4);

figure, imshow([IM1,newIM1])
figure, imshow([IM2,newIM2])
figure, imshow([IM3,newIM3])