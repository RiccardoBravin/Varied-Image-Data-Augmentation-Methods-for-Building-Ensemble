% net = unitGenerator([256,256,3]);
% 
% img = imread("img.jpg");
% img = imresize(img,[256,256]);
% img = im2single(img);
% 
% img = dlarray(img,"SSCB");
% 
% output = unitPredict(net,img);
% output = rescale(extractdata(output));
% imshow(output);

m = 15; n = 15; 
[X,Y] = meshgrid(1:m,1:n) ; 
Z = 255*ones(m,n) ; 
idx = randperm(m*n,100) ; 
Z(idx) = 0 ; 
% pcolor(X,Y,Z)
imshow(Z)
grid on