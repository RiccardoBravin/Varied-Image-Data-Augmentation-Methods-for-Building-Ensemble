%Discrete-time analitic signal column by column using hilbert transform 
disp("Hilbert transform");
try

    interval = [1:tr_data_sz];  %intervallo da cui campionare immagini
    
    for pattern = interval
        img(:,:,:)=training_imgs(:,:,:,pattern);
        I = im2double(img);
        
        for plane = 1:3    
            I(:,:,plane) = hilbert(I(:,:,plane));
        end
        %montage({training_imgs(:,:,:,pattern),uint8(img)}); pause(0.5);

        training_imgs(:,:,:,end+1) = rescale(angle(I),0,255);
        training_lbls(end+1)=training_lbls(pattern);

    end

catch ERROR
    disp(strcat("Errore a riga ",num2str(ERROR.stack.line(end))));
    disp(ERROR.message);
    disp("\nSomething went wrong inside the augmentation\nTo restore the training set use the backup training_imgs_bk and lables\n");
    keyboard;
end

clearvars pattern img interval
clearvars plane j I


