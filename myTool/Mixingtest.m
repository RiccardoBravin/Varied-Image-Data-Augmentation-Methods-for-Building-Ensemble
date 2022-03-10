types = {'gauss','average','disk','log','motion'};

for pattern = interval
    i = 1;
    while i <= iterations
        img(:,:,:)=training_imgs(:,:,:,pattern);
        mod = false;

%         %vignetting
%         if round(rand())
%             mod = true;
%             distanceImage = fspecial('gaussian',size(img(:,:,1)), 30000); % crea un filtro gaussiano
%             distanceImage = rescale(distanceImage,rand()/3,1);
%             distanceImage = cat(3, distanceImage, distanceImage, distanceImage);
%             img = uint8(double(img) .* distanceImage);
%         end

%         %dehaze
%         if round(rand())
%             mod = true;
%             img = imreducehaze(img, rand()/2+0.5);
%         end

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


        %denoise
        if round(rand())
            mod = true;
            R = medfilt2(img(:,:,1));
            G = medfilt2(img(:,:,2));
            B = medfilt2(img(:,:,3));

            img = cat(3,R,G,B);
        end

        %color reduction
        if round(rand())
            mod = true;
            [IND,map] = rgb2ind(img, randi([16,64]),'nodither');
            img = uint8(ind2rgb(IND,map)*255);
        end


        %project
        if round(rand())
            mod = true;
            T = [1              rand()/2-0.25 rand()/1000000;
                rand()/2-0.25   1             rand()/10000;
                rand()/100000   0             1];
            T = projective2d(T);
            img = imwarp(img,T,'FillValues',randi([0,255]));
            img = imresize(img,im_dim);
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

