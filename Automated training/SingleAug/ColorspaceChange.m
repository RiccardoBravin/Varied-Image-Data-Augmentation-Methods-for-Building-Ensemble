%changes the colorspace to yiq using the written function
disp("Change colorspace to yiq");
try
    interval = [1:tr_data_sz];  %intervallo da cui campionare immagini

    for pattern = interval

        img(:,:,:)=training_imgs(:,:,:,pattern);

        training_imgs(:,:,:,end+1) = rgb2yiq(img);
        training_lbls(end+1)=training_lbls(pattern);

    end

catch ERROR
    ERROR
    disp("\nSomething went wrong inside the augmentation\nTo restore the training set use the backup training_imgs_bk and lables\n");
    keyboard;
end

clearvars pattern img interval

