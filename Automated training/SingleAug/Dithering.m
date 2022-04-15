%Reduces the colors of the image using dithering
disp("Dithering");
try
    interval = [1:tr_data_sz];  %intervallo da cui campionare immagini

    for pattern = interval
        
            img(:,:,:)=training_imgs(:,:,:,pattern);

            [IND,map] = rgb2ind(img, randi([6,12]));
            img = uint8(ind2rgb(IND,map)*255);

            training_imgs(:,:,:,end+1) = img;
            training_lbls(end+1)=training_lbls(pattern);
    end

catch ERROR
    ERROR
    disp("\nSomething went wrong inside the augmentation\nTo restore the training set use the backup training_imgs_bk and lables\n");
    keyboard;
end

clearvars pattern img interval
clearvars IND map
