%uses the hampel signal denoiser on the image
disp("Hampel filter");
try
    interval = [1:tr_data_sz];  %intervallo da cui campionare immagini

    for pattern = interval
        img(:,:,:)=training_imgs(:,:,:,pattern);
        R = im2double(img(:,:,1));
        G = im2double(img(:,:,2));
        B = im2double(img(:,:,3));

        LR = [];
        LG = [];
        LB = [];

        for j = 1:size(R,1)
            LR = [LR,R(j,:)];
            LG = [LG,G(j,:)];
            LB = [LB,B(j,:)];
        end

        LR = hampel(LR,20,1.5);
        LG = hampel(LG,20,1.5);
        LB = hampel(LB,20,1.5);

        for j = 1:size(R,1)
            R(j,:) = LR((j-1)*size(R,1)+ 1: j*size(R,1));
            G(j,:) = LG((j-1)*size(R,1)+ 1: j*size(R,1));
            B(j,:) = LB((j-1)*size(R,1)+ 1: j*size(R,1));
        end

        img = uint8(rescale(cat(3,R,G,B),0,255));
        %montage({training_imgs(:,:,:,pattern), img}); pause(.5);

        training_imgs(:,:,:,end+1) = img;
        training_lbls(end+1)=training_lbls(pattern);

    end

catch ERROR
    ERROR
    disp("\nSomething went wrong inside the augmentation\nTo restore the training set use the backup training_imgs_bk and lables\n");
    keyboard;
end

clearvars pattern img interval
clearvars LR LG LB R G B

