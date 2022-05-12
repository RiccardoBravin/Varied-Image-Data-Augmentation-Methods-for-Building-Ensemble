%Calculate radon transform and adding salt & pepper noise
disp("Radon transform");
try
    interval = [1:tr_data_sz];  %intervallo da cui campionare immagini

    for pattern = interval

        img(:,:,:)=training_imgs(:,:,:,pattern);

        for plane = 1:3
            I = im2double(img(:,:,plane));
            I = radon(I, 1:179);
            
            M = rand(size(I)) < 0.003;
            I(M) = max(max(I));
            
            I = iradon(I,1:179,im_dim(1));

            Oimg(:,:,plane) = uint8(I*255);

        end

        %montage({training_imgs(:,:,:,pattern), Oimg}); pause(0.5);
        training_imgs(:,:,:,end+1) = Oimg;
        training_lbls(end+1)=training_lbls(pattern);


        for plane = 1:3
            I = im2double(img(:,:,plane));
            I = radon(I, 1:179);
            
            I = locallapfilt(uint16(I),0.4,0.1);
            
            I = iradon(I,1:179,im_dim(1));

            Oimg(:,:,plane) = uint8(I*255);
        end
        %montage({training_imgs(:,:,:,pattern), Oimg}); pause(0.5);
        training_imgs(:,:,:,end+1) = img;
        training_lbls(end+1)=training_lbls(pattern);

    end

catch ERROR
    ERROR
    disp("\nSomething went wrong inside the augmentation\nTo restore the training set use the backup training_imgs_bk and lables\n");
    keyboard;
end

clearvars pattern img interval
clearvars I M Oimg
