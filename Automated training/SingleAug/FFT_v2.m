%FFT with removal of random values
disp("Random removal with FFT");
try
    interval = [1:tr_data_sz];  %intervallo da cui campionare immagini

    for pattern = interval
        
            img(:,:,:)=training_imgs(:,:,:,pattern);

            for plane = 1:3
                X = fft2(img(:,:,plane));
                ind = logical(abs(X) < mean(std(X))) ;
                X(ind) = 0;
                img(:,:,plane) = (uint8(rescale(abs(fft2(X)),0,255)));
            end

            %montage({training_imgs(:,:,:,pattern), img});% pause(1);

            training_imgs(:,:,:,end+1) = img;
            training_lbls(end+1)=training_lbls(pattern);
            
    end

catch ERROR
    ERROR
    disp("\nSomething went wrong inside the augmentation\nTo restore the training set use the backup training_imgs_bk and lables\n");
    keyboard;
end

clearvars pattern img interval
clearvars plane X ind

