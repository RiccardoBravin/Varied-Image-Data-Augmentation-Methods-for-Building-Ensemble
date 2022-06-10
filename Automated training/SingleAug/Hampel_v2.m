%uses the hampel signal denoiser on the image
disp("Hampel filter");
try
    interval = [1:tr_data_sz];  %intervallo da cui campionare immagini

    for pattern = interval
        img(:,:,:)=training_imgs(:,:,:,pattern);
        I = im2double(img);

        for plane = 1:3
            L = [];
            for j = 1:size(I,1)
                L = [L(:,:),I(j,:,plane)];
            end

            L = hampel(L,20,1.5);

            for j = 1:size(I,1)
                I(j,:,plane) = L((j-1)*size(I,1)+ 1: j*size(I,1));
            end
        end
        img = uint8(rescale(I,0,255));
        %montage({training_imgs(:,:,:,pattern), img}); pause(.5);

        training_imgs(:,:,:,end+1) = img;
        training_lbls(end+1)=training_lbls(pattern);

    end

catch ERROR
    ERROR.stack
    disp("\nSomething went wrong inside the augmentation\nTo restore the training set use the backup training_imgs_bk and lables\n");
    keyboard;
end

clearvars pattern img interval
clearvars LR LG LB R G B

