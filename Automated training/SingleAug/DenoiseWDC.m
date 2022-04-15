%Applies the wdencmp denoising function to the image
disp("Denosing WDC");
try
    interval = [1:tr_data_sz];  %intervallo da cui campionare immagini

    for pattern = interval

        img(:,:,:)=training_imgs(:,:,:,pattern);

        [thr,sorh,keepapp] = ddencmp('den','wv',img(:,:,1));
        R = wdencmp('gbl',img(:,:,1),'sym4',2,thr,sorh,keepapp);
        [thr,sorh,keepapp] = ddencmp('den','wv',img(:,:,2));
        G = wdencmp('gbl',img(:,:,2),'sym4',2,thr,sorh,keepapp);
        [thr,sorh,keepapp] = ddencmp('den','wv',img(:,:,3));
        B = wdencmp('gbl',img(:,:,3),'sym4',2,thr,sorh,keepapp);

        img = uint8(cat(3,R,G,B));
        %montage({training_imgs(:,:,:,pattern), img});pause(1);

        training_imgs(:,:,:,end+1) = img;
        training_lbls(end+1)=training_lbls(pattern);
    end

catch ERROR
    ERROR
    disp("\nSomething went wrong inside the augmentation\nTo restore the training set use the backup training_imgs_bk and lables\n");
    keyboard;
end

clearvars pattern img interval
clearvars thr sorh keepapp R G B

