%Removes an entire channel from the input image
disp("Channel Removal");
try
    interval = [1:tr_data_sz];  %intervallo da cui campionare immagini

    for pattern = interval
        img(:,:,:)=training_imgs(:,:,:,pattern);

        %removing random channel
        img(:,:,randi([1,3])) = 0;

        training_imgs(:,:,:,end+1) = img;
        training_lbls(end+1)=training_lbls(pattern);
    end

catch ERROR
    disp(strcat("Errore a riga ",num2str(ERROR.stack.line(end))));
    disp(ERROR.message);
    disp("\nSomething went wrong inside the augmentation\nTo restore the training set use the backup training_imgs_bk and lables\n");
    keyboard;
end


clearvars pattern img interval

