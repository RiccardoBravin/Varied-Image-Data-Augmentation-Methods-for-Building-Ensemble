%Image denoising with median filter
disp("MF2 denoising"),
try
    interval = [1:tr_data_sz];  %intervallo da cui campionare immagini

    for pattern = interval

        img(:,:,:)=training_imgs(:,:,:,pattern);
        
        img(:,:,1) = medfilt2(img(:,:,1));
        img(:,:,2) = medfilt2(img(:,:,2));
        img(:,:,3) = medfilt2(img(:,:,3));

        %montage({training_imgs(:,:,:,pattern), img}); pause(2);

        training_imgs(:,:,:,end+1) = img;
        training_lbls(end+1)=training_lbls(pattern);


    end

catch ERROR
    ERROR
    disp("\nSomething went wrong inside the augmentation\nTo restore the training set use the backup training_imgs_bk and lables\n");
    keyboard;
end

clearvars pattern img interval 
clearvars R G B
