%uses localaptfilt (laplacian) for extracting edges or smoothing colors
disp("Laplacian filters");
try
    
    interval = [1:tr_data_sz];  %intervallo da cui campionare immagini

    for pattern = interval
        img(:,:,:)=training_imgs(:,:,:,pattern);

        outImg = locallapfilt(img, 0.5,rand()/3);
        training_imgs(:,:,:,end+1) = outImg;
        training_lbls(end+1)=training_lbls(pattern);
        %montage({training_imgs(:,:,:,pattern), outImg}); pause(0.5);

        outImg = locallapfilt(img, 0.2,2.5);
        training_imgs(:,:,:,end+1) = outImg;
        training_lbls(end+1)=training_lbls(pattern);

        %montage({training_imgs(:,:,:,pattern), outImg}); pause(0.5);

        outImg = locallapfilt(img, 255,0.8,0.1);
        training_imgs(:,:,:,end+1) = outImg;
        training_lbls(end+1)=training_lbls(pattern);

        %montage({training_imgs(:,:,:,pattern), outImg}); pause(0.5);

    end

catch ERROR
    ERROR
    disp("\nSomething went wrong inside the augmentation\nTo restore the training set use the backup training_imgs_bk and lables\n");
    keyboard;
end

clearvars pattern img interval 
clearvars outImg

