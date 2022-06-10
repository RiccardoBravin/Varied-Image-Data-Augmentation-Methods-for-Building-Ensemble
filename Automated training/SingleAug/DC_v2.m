%Applies DCT two times and adds some post processing to make the image more
%readable
disp("DCT ripetuta");
try

    interval = [1:tr_data_sz];  %intervallo da cui campionare immagini


    for pattern = interval

        img(:,:,:)=training_imgs(:,:,:,pattern);


        for plane = 1:3
            I = dct2(img(:,:,plane));
            I = uint8(rescale(dct2(I),0,255));
            img(:,:,plane) = histeq(imreducehaze(I));
        end

        %montage({training_imgs(:,:,:,pattern), img});pause(0.5);

        training_imgs(:,:,:,end+1) = img;
        training_lbls(end+1)=training_lbls(pattern);

    end

catch ERROR
    ERROR
    disp("\nSomething went wrong inside the augmentation\nTo restore the training set use the backup training_imgs_bk and lables\n");
    keyboard;
end

clearvars pattern img interval
clearvars R G B
