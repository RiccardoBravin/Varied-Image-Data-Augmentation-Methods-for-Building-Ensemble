%generates chunks of color using superpixelation
disp("Superpixel");
try
    
    interval = [1:tr_data_sz];  %intervallo da cui campionare immagini

    for pattern = interval
        
            img(:,:,:)=training_imgs(:,:,:,pattern);

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
            training_imgs(:,:,:,end+1) = im_result;
            training_lbls(end+1)=training_lbls(pattern);

    end

catch ERROR
    ERROR
    disp("\nSomething went wrong inside the augmentation\nTo restore the training set use the backup training_imgs_bk and lables\n");
    keyboard;
end

clearvars pattern img  interval
clearvars pos im_result idx redIdx greenIdx blueIdx L N   