try
    append=1;%da dove partire a inserire immagini
    iterations = 1; %cambiare prima di ogni chiamata a file per modificare il numero di immagini generate
    interval = [1:tr_data_sz]; %intervallo da cui campionare immagini

    types = {'gauss','average','disk','log'};

    for pattern = interval
        i = 1;
        img(:,:,:) = training_imgs(:,:,:,pattern);
        while i <= iterations

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
            training_imgs(:,:,:,tr_data_sz+append) = im_result;
            training_lbls(tr_data_sz+append)=training_lbls(pattern);
            append = append + 1;

            %deform
            training_imgs(:,:,:,tr_data_sz+append) = elasticDeformation(img, types(randi([1,4])), randi([700,1500]));
            training_lbls(tr_data_sz+append)=training_lbls(pattern);
            append = append + 1;

            %color reduction
            [IND,map] = rgb2ind(img, randi([16,64]),'nodither');
            training_imgs(:,:,:,tr_data_sz+append) = uint8(ind2rgb(IND,map)*255);
            training_lbls(tr_data_sz+append)=training_lbls(pattern);
            append = append + 1;

            %denoisemf2
            R = medfilt2(img(:,:,1));
            G = medfilt2(img(:,:,2));
            B = medfilt2(img(:,:,3));
            training_imgs(:,:,:,tr_data_sz+append) = cat(3,R,G,B);
            training_lbls(tr_data_sz+append)=training_lbls(pattern);
            append = append + 1;

            %color variation
            training_imgs(:,:,:,tr_data_sz+append) = color_variation(img, randi([-40,40]),randi([-40,40]),randi([-40,40]));
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
clearvars i pattern img T distanceImage IND map redIdx greenIdx blueIdx im_result idx R G B
clearvars squareSizeX squareX rangeX1 squareSizeY squareY rangeY1 rangeX2 rangeY2 x y h k im_result
clearvars append iterations inverval his I j L Ins mod N pos types vec
