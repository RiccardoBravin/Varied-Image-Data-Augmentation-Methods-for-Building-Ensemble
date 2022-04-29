%Does the deconvolution of the original image with a gaussian filter
disp("Deconvolution");
try
    interval = [1:tr_data_sz];  %intervallo da cui campionare immagini
    for pattern = interval

        img(:,:,:)=training_imgs(:,:,:,pattern);

        PSF = imnoise(zeros(randi([4,8])),"gaussian", 1);
        training_imgs(:,:,:,end+1) = deconvblind(img,PSF);
        training_lbls(end+1)=training_lbls(pattern);
        %montage({training_imgs(:,:,:,pattern), training_imgs(:,:,:,end)});pause(0.5);
    end

catch ERROR
    ERROR
    disp("\nSomething went wrong inside the augmentation\nTo restore the training set use the backup training_imgs_bk and lables\n");
    keyboard;
end

clearvars pattern img interval
clearvars PSF