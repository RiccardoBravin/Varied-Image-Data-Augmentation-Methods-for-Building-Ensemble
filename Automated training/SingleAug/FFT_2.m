%Calculating phase from FFT and flipping it
disp("FFT phase flip");
try
    interval = [1:tr_data_sz];  %intervallo da cui campionare immagini

    for pattern = interval

        img(:,:,:)=training_imgs(:,:,:,pattern);

        for plane = 1:3
            I = fft2(img(:,:,plane));
            mag = abs(I);
            phs = angle(I);
            mag = flip(mag,1);
            I = mag.*exp(1i.*phs);
            img(:,:,plane) = uint8(abs(ifft2(I)));

        end

        %montage({training_imgs(:,:,:,pattern), img}); pause(0.5);

        training_imgs(:,:,:,end+1) = img;
        training_lbls(end+1)=training_lbls(pattern);


    end

catch ERROR
    ERROR
    disp("\nSomething went wrong inside the augmentation\nTo restore the training set use the backup training_imgs_bk and lables\n");
    keyboard;
end

clearvars pattern img interval
clearvars I mag phs plane

