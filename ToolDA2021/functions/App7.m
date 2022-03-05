append=1;
for pattern=1:DIM
    IM(:,:,:)=trainingImages(:,:,:,pattern);

    %data augmentation
    trainingImages(:,:,:,DIM+append) = jitterColorHSV(IM,'Hue',[0.05 0.15]);
    AddLabel;

    trainingImages(:,:,:,DIM+append) = jitterColorHSV(IM,'Saturation',[-0.4 -0.1]);
    AddLabel;

    trainingImages(:,:,:,DIM+append) = jitterColorHSV(IM,'Brightness',[-0.3 -0.1]);
    AddLabel;

    trainingImages(:,:,:,DIM+append) = jitterColorHSV(IM,'Contrast',[1.2 1.4]);
    AddLabel;

    sigma = 1+5*rand;
    trainingImages(:,:,:,DIM+append) = imgaussfilt(IM,sigma);
    AddLabel;

    %sharpness
    trainingImages(:,:,:,DIM+append) =  imsharpen(IM,'Radius',1,'Amount',2,'Threshold',0); %matlab function
    AddLabel;

    %shifting_color
    OtherIMG=randperm(5);
    shifting_color = [ 20, -20,  5, 50, 50;
        -20,  20,  0,  0, 0;
        20,  20, 50, -10, -100];
    trainingImages(:,:,:,DIM+append) = color_shifting(IM, shifting_color(1,OtherIMG(1)),...
        shifting_color(2,OtherIMG(1)), shifting_color(3,OtherIMG(1)));
    AddLabel;%add label of the new pattern

end