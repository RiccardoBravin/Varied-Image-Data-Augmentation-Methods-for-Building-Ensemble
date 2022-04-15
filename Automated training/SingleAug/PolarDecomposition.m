%shuffles the polar decomposition matrices of the different color planes
disp("Polar decomposition");
try
    interval = [1:tr_data_sz];  %intervallo da cui campionare immagini

    for pattern = interval
        img(:,:,:)=training_imgs(:,:,:,pattern);

        R = im2double(img(:,:,1));
        G = im2double(img(:,:,2));
        B = im2double(img(:,:,3));

        [U,S,V] = svd(R);
        RK = U*V';
        RM = V*S*V';

        [U,S,V] = svd(G);
        GK = U*V';
        GM = V*S*V';

        [U,S,V] = svd(B);
        BK = U*V';
        BM = V*S*V';

        R = GK*RM*255;
        G = RK*GM*255;
        B = GK*BM*255;

        img = uint8(cat(3,R,G,B));
        %montage({training_imgs(:,:,:,pattern),uint8(img)}); pause(.5);

        training_imgs(:,:,:,end+1) = img;
        training_lbls(end+1)=training_lbls(pattern);
    end

catch ERROR
    ERROR
    disp("\nSomething went wrong inside the augmentation\nTo restore the training set use the backup training_imgs_bk and lables\n");
    keyboard;
end

clearvars pattern img interval
clearvars U V S RK RM GK GM BK BM R G B

