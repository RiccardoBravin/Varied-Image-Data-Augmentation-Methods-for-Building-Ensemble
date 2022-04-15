%Applies the dehaze function to the image
disp("Dehaze");
try
    
    interval = [1:tr_data_sz];  %intervallo da cui campionare immagini

    for pattern = interval
        
            img(:,:,:)=training_imgs(:,:,:,pattern);

            training_imgs(:,:,:,end+1) = imreducehaze(img, rand()/2+0.5);
            training_lbls(end+1)=training_lbls(pattern);

    end

catch ERROR
    ERROR
    disp("\nSomething went wrong inside the augmentation\nTo restore the training set use the backup training_imgs_bk and lables\n");
    keyboard;
end

clearvars pattern img interval