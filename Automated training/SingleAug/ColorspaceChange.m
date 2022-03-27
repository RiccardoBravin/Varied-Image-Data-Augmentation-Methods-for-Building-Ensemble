try

    append=1;%da dove partire a inserire immagini
    iterations = 1; %cambiare prima di ogni chiamata a file per modificare il numero di immagini generate
    interval = [1:tr_data_sz];%intervallo da cui campionare immagini

    for pattern = interval

        img(:,:,:)=training_imgs(:,:,:,pattern);

        training_imgs(:,:,:,tr_data_sz+append) = rgb2yiq(img);
        training_lbls(tr_data_sz+append)=training_lbls(pattern);
        append = append + 1;

    end

catch ERROR
    ERROR;
    disp("\nDataset could be corrupted, restore it with the training_imgs_bk and lables\n");
    keyboard;
end

clearvars i pattern img j vec lns

