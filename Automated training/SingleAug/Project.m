%projects the image in a skewed plane distorting it
disp("Project");
try
    interval = [1:tr_data_sz];  %intervallo da cui campionare immagini

    for pattern = interval
        img(:,:,:)=training_imgs(:,:,:,pattern);

        T = [1              rand()/2-0.25    rand()/1000000;
            rand()/2-0.25      1             rand()/10000;
            rand()/100000   0             1];
        T = projective2d(T);
        img = imwarp(img,T,'FillValues',randi([0,255]));
        img = imresize(img,im_dim);

        %montage({training_imgs(:,:,:,pattern), img});pause(1);

        training_imgs(:,:,:,end+1) = img;
        training_lbls(end+1)=training_lbls(pattern);

    end

catch ERROR
    ERROR
    disp("\nSomething went wrong inside the augmentation\nTo restore the training set use the backup training_imgs_bk and lables\n");
    keyboard;
end

clearvars i pattern img interval
clearvars T

