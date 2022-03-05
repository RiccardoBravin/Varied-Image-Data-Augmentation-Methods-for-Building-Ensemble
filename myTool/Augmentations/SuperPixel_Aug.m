
for pattern = interval
    i = 1;
    while i <= iterations
        img(:,:,:)=training_imgs(:,:,:,pattern);
        mod = false;
        %imshow(img);
        
        %SuperPixel
        if round(rand())
            mod = true;
            
            [L,N] = superpixels(img, 2000 + randi([- 200 500])); %genera una matrice L e il numero di superpixel ottenuti
            
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
        end
        
        %RandXReflection
        if round(rand())
            mod = true;
            img = flip(img,1);
        end
        
        %RandYReflection
        if round(rand())
            mod = true;
            img = flip(img,2);
        end
        
        %RandScale
        if round(rand())
            mod = true;
            tform = randomAffine2d('Scale',[1.1,1.3]);
            outputView = affineOutputView(size(img),tform);
            img = imwarp(img,tform,'OutputView',outputView);
        end
        
        
        %RandRotation
        if round(rand())
            mod = true;
            tform = randomAffine2d('Rotation',[-10 10]);
            outputView = affineOutputView(size(img),tform);
            img = imwarp(img,tform,'OutputView',outputView);
        end
        
        %translation
        if round(rand())
            mod = true;
            tform = randomAffine2d('XTranslation',[-5 5],'YTranslation',[-5 5]);
            outputView = affineOutputView(size(img),tform);
            img = imwarp(img,tform,'OutputView',outputView);
        end
        
        %shear
        if round(rand())
            mod = true;
            tform = randomAffine2d('XShear',[0 20],'YShear',[0 20]);
            outputView = affineOutputView(size(img),tform);
            img = imwarp(img,tform,'OutputView',outputView);
        end
        
        
        if mod %add the image only if it has been modified
            training_imgs(:,:,:,tr_data_sz+append) = img;
            training_lbls(tr_data_sz+append)=training_lbls(pattern);
            append = append + 1;
            i = i + 1;
        end
    end
end


clearvars  i pattern im_result idx redIdx greenIdx blueIdx img L N

function meanVal = myMean(v)
    meanVal = sum(v)/size(v,1); %impiega meno di metà del tempo di quella di matlab...
end
