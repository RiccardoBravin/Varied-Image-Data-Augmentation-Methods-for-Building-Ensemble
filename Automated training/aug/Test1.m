
append=1;%da dove partire a inserire immagini
iterations = 2; %cambiare prima di ogni chiamata a file per modificare il numero di immagini generate
interval = [1:tr_data_sz]; %intervallo da cui campionare immagini

types = {'gauss','average','disk','log','motion'};

for pattern = interval
    i = 1;
    while i <= iterations
        img(:,:,:)=training_imgs(:,:,:,pattern);
        mod = false;

        %deform
        if round(rand())
            mod = true;
            img = elasticDeformation(img, types(randi([1,5])), randi([500,1000]));
        end

        %color variation
        if round(rand())
            mod = true;
            img = color_variation(img, randi([-40,40]),randi([-40,40]),randi([-40,40]));
        end

        %color reduction
        if round(rand())
            mod = true;
            [IND,map] = rgb2ind(img, randi([16,64]),'nodither');
            img = uint8(ind2rgb(IND,map)*255);
        end

        
        %superpixel
        if round(rand())
            mod = true;
            [L,N] = superpixels(img, randi([3000 5000])); %genera una matrice L e il numero di superpixel ottenuti

            im_result = zeros(im_dim(1), im_dim(1), 3, 'uint8'); %preallocazione

            idx = label2idx(L); %genera indici dalle lable della matrice

            for pos = 1:N %per ogni superpixel
                redIdx = idx{pos}; %prende le posizioni dei pixel rossi nel superpixel
                greenIdx = idx{pos}+im_dim(1)*im_dim(2);
                blueIdx = idx{pos}+2*im_dim(1)*im_dim(2);
                im_result(redIdx) = myMean(img(redIdx)); %imposta il colore dei pixel di un area al valore della media
                im_result(greenIdx) = myMean(img(greenIdx));
                im_result(blueIdx) = myMean(img(blueIdx));        %LA FUNZIONE MEAN DI MATLAB È LENTISSIMA, IMPLEMENTANE UNA AD HDOC
            end

            img = im_result;
        end


        if mod %add the image only if it has been modified
            training_imgs(:,:,:,tr_data_sz+append) = img;
            training_lbls(tr_data_sz+append)=training_lbls(pattern);
            append = append + 1;
            i = i + 1;
        end
    end
end

clearvars i pattern img T distanceImage IND map redIdx greenIdx blueIdx im_result idx R G B 

