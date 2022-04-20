%Generates the classic augmentations like flip, rotate, noise and crop
disp("Classic");
try
    interval = [1:tr_data_sz];  %intervallo da cui campionare immagini
    for pattern = interval
        img(:,:,:)=training_imgs(:,:,:,pattern);

        %FlipX
        outImg = flipdim(img ,1);
        training_imgs(:,:,:,end+1) = outImg;
        training_lbls(end+1)=training_lbls(pattern);

        %FlipY
        outImg = flipdim(img ,2);
        training_imgs(:,:,:,end+1) = outImg;
        training_lbls(end+1)=training_lbls(pattern);

        %Rotate
        outImg = imresize(imrotate(img, randi([0,180])),im_dim);
        training_imgs(:,:,:,end+1) = outImg;
        training_lbls(end+1)=training_lbls(pattern);

        %Noise
        outImg = imnoise(img,"gaussian");
        training_imgs(:,:,:,end+1) = outImg;
        training_lbls(end+1)=training_lbls(pattern);

        %Crop
        outImg = imresize(imcrop(img,[randi([0,20]),randi([0,20]),randi([200,224]),randi([200,224])]),im_dim);
        training_imgs(:,:,:,end+1) = outImg;
        training_lbls(end+1)=training_lbls(pattern);


        %hue jitter
        outImg = jitterColorHSV(img,'Hue',[0.05 0.15]);
        training_imgs(:,:,:,end+1) = outImg;
        training_lbls(end+1)=training_lbls(pattern);


        %Saturation jitter
        outImg = jitterColorHSV(img,'Saturation',[-0.4 -0.1]);
        training_imgs(:,:,:,end+1) = outImg;
        training_lbls(end+1)=training_lbls(pattern);

        %Brightness jitter
        outImg = jitterColorHSV(img,'Brightness',[-0.3 -0.1]);
        training_imgs(:,:,:,end+1) = outImg;
        training_lbls(end+1)=training_lbls(pattern);

        %Contrast jitter
        outImg = jitterColorHSV(img,'Contrast',[1.2 1.4]);
        training_imgs(:,:,:,end+1) = outImg;
        training_lbls(end+1)=training_lbls(pattern);

    end

catch ERROR
    disp(strcat("Errore a riga ",num2str(ERROR.stack.line)));
    disp(ERROR.message);
    disp("\nSomething went wrong inside the augmentation\nTo restore the training set use the backup training_imgs_bk and lables\n");
    keyboard;
end

clearvars i pattern img append iterations interval outImg

