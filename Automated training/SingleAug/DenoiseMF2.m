try

    append = 1;%da dove partire a inserire immagini
    iterations = 1; %cambiare prima di ogni chiamata a file per modificare il numero di immagini generate
    interval = [1:tr_data_sz];%intervallo da cui campionare immagini

    for pattern = interval

        img(:,:,:)=training_imgs(:,:,:,pattern);

        R = medfilt2(img(:,:,1));
        G = medfilt2(img(:,:,2));
        B = medfilt2(img(:,:,3));

        img = cat(3,R,G,B);


        training_imgs(:,:,:,tr_data_sz+append) = img;
        training_lbls(tr_data_sz+append)=training_lbls(pattern);
        append = append + 1;

    end

catch ERROR
    ERROR;
    disp("\nDataset could be corrupted, restore it with the training_imgs_bk and lables\n");
    keyboard;
end


clearvars i pattern img R G B X ind

