function [rotate_im] = random_90_rotate(im)
x = randi([1,3],1);
if x == 1
    %rotate of 90 degree
    rotate = imrotate(im, 90);
end
if x == 2
    %rotate of 180 degree
    rotate = imrotate(im, 180);
end
if x == 3
    %rotate of 270 degree
    rotate = imrotate(im, 270);
end
rotate_im = rotate;
end

