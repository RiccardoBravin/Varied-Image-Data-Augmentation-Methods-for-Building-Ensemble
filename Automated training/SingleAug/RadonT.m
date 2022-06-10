%Calculate radon transform and adding salt & pepper noise
disp("Radon transform");
try
    interval = [1:tr_data_sz];  %intervallo da cui campionare immagini

    for pattern = interval

        img = training_imgs(:,:,:,pattern);
        
        img = im2double(img);
        
        for plane = 1:3
            
            I = radon(img(:,:,plane), 1:179);
            
            M = rand(size(I)) < 0.003;
            I1 = I;
            I1(M) = max(max(I));
            %fist modification
            Oimg1(:,:,plane) = iradon(I1,1:179,im_dim(1));
            %imagesc(Oimg1)
            
            I2 = locallapfilt(uint16(I),0.4,0.1);
            %second modification
            Oimg2(:,:,plane) = iradon(I2,1:179,im_dim(1));

        end
        
        %Oimg1 = uint8(Oimg1*255);
        %Oimg2 = uint8(Oimg2*255);

        %montage({training_imgs(:,:,:,pattern), Oimg1}); pause(0.5);
        training_imgs(:,:,:,end+1) = Oimg1;
        training_lbls(end+1)=training_lbls(pattern);

        %montage({training_imgs(:,:,:,pattern), Oimg2}); pause(0.5);
        training_imgs(:,:,:,end+1) = Oimg2;
        training_lbls(end+1)=training_lbls(pattern);

    end

catch ERROR
    ERROR
    disp("\nSomething went wrong inside the augmentation\nTo restore the training set use the backup training_imgs_bk and lables\n");
    keyboard;
end

clearvars pattern img interval
clearvars I1 I2 M Oimg1 Oimg1
