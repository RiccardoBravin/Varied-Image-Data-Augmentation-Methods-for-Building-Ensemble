%function that create a color based vector v to an rgb image IM
function[v] = color_vectoritation(IM)

    %Split into RGB Channels
    Red = IM(:,:,1);
    Green = IM(:,:,2);
    Blue = IM(:,:,3);
    
    %Get histValues for each channel
    [yRed, x] = imhist(Red);
    [yGreen, x] = imhist(Green);
    [yBlue, x] = imhist(Blue);
    
    v = [yRed.', yGreen.', yBlue.'];