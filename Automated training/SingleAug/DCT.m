%Applies DCT two times and adds some post processing to make the image more
%readable
disp("DCT ripetuta");
try
    
    interval = [1:tr_data_sz];  %intervallo da cui campionare immagini


    for pattern = interval
        
            img(:,:,:)=training_imgs(:,:,:,pattern);

            R = dct2(img(:,:,1));
            G = dct2(img(:,:,2));
            B = dct2(img(:,:,3));

            R = uint8(rescale(dct2(R),0,255));
            G = uint8(rescale(dct2(G),0,255));
            B = uint8(rescale(dct2(B),0,255));

            R = histeq(imreducehaze(R));
            G = histeq(imreducehaze(G));
            B = histeq(imreducehaze(B));

            img = uint8(cat(3,R,G,B));

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
