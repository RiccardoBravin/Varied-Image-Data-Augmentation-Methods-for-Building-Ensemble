%function to couple two rgb IM1 and IM2 and return a new rgb IM
function[IM1] = couple(IM1, IM2)
%decompose the 3 colour channel
allBlack = zeros(size(IM1, 1), size(IM1, 2), 'uint8');

plane = randi([1,3]);%I want a randomic color plane choose

redChannel = cat(3, IM1(:,:,1), allBlack, allBlack);
greenChannel = cat(3, allBlack, IM1(:,:,2), allBlack);
blueChannel = cat(3, allBlack, allBlack, IM1(:,:,3));

redChannel2 = cat(3, IM2(:,:,1), allBlack, allBlack);
greenChannel2 = cat(3, allBlack, IM2(:,:,2), allBlack);
blueChannel2 = cat(3, allBlack, allBlack, IM2(:,:,3));

if plane == 1
  IM1(:,:,1) = redChannel2(:,:,1); %exchage the red planes
end
if plane == 2
  IM1(:,:,2) = greenChannel2(:,:,2); %exchage the green planes
end
if plane == 3
  IM1(:,:,3) = blueChannel2(:,:,3); %exchage the blue planes
end