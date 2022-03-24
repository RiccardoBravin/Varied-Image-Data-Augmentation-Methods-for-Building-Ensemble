try

    append = 1;%da dove partire a inserire immagini
    iterations = 1; %cambiare prima di ogni chiamata a file per modificare il numero di immagini generate
    interval = [1:tr_data_sz];%intervallo da cui campionare immagini

    for pattern = interval
        i = 1;
        while i <= iterations
            img(:,:,:)=training_imgs(:,:,:,pattern);
            %imshow(img);

            %superpixel
            [L,N] = superpixels(img, randi([300 2000])); %genera una matrice L e il numero di superpixel ottenuti

            im_result = zeros(im_dim(1), im_dim(1), 3, 'uint8'); %preallocazione

            idx = label2idx(L); %genera indici dalle lable della matrice

            for pos = 1:N %per ogni superpixel
                redIdx = idx{pos}; %prende le posizioni dei pixel rossi nel superpixel
                greenIdx = idx{pos}+im_dim(1)*im_dim(2);
                blueIdx = idx{pos}+2*im_dim(1)*im_dim(2);
                im_result(redIdx) = myMean(img(redIdx)); %imposta il colore dei pixel di un area al valore della media
                im_result(greenIdx) = myMean(img(greenIdx));
                im_result(blueIdx) = myMean(img(blueIdx));
            end

            %imshow(im_result);
            training_imgs(:,:,:,tr_data_sz+append) = im_result;
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

clearvars  i pattern im_result idx redIdx greenIdx blueIdx img L N append iterations interval