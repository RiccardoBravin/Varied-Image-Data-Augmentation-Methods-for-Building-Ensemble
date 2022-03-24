try

    append = 1;%da dove partire a inserire immagini
    iterations = 2; %cambiare prima di ogni chiamata a file per modificare il numero di immagini generate
    interval = [1:tr_data_sz];%intervallo da cui campionare immagini

    types = {'gauss','average','disk','log'};

    for pattern = interval
        i = 1;
        while i <= iterations
            img(:,:,:)=training_imgs(:,:,:,pattern);

            img = elasticDeformation(img, types(randi([1,4])), randi([700,1500]));

            %montage({training_imgs(:,:,:,pattern), img});

            training_imgs(:,:,:,tr_data_sz+append) = img;
            training_lbls(tr_data_sz+append)=training_lbls(pattern);
            append = append + 1;
            i = i + 1;

        end
    end

catch ERROR
    ERROR;
    disp("\nDataset could be corrupted, restore it with the training_imgs_bk and lables\n");
    keyboard;
end

clearvars i pattern img types
clearvars interval append iterations
