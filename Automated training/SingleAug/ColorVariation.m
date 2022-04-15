%varies the color of the images adding or subtracting random values
disp("Color variation");
try
    interval = [1:tr_data_sz];  %intervallo da cui campionare immagini

    for pattern = interval
        img(:,:,:)=training_imgs(:,:,:,pattern);
        
        img = color_variation(img, randi([-40,40]),randi([-40,40]),randi([-40,40]));

        %montage({training_imgs(:,:,:,pattern), img});pause(1);

        training_imgs(:,:,:,end+1) = img;
        training_lbls(end+1)=training_lbls(pattern);

    end

catch ERROR
    ERROR
    disp("\nSomething went wrong inside the augmentation\nTo restore the training set use the backup training_imgs_bk and lables\n");
    keyboard;
end

clearvars pattern img interval

