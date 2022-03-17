
append=1;%da dove partire a inserire immagini
iterations = 2; %cambiare prima di ogni chiamata a file per modificare il numero di immagini generate
interval = [1:tr_data_sz]; %intervallo da cui campionare immagini

types = {'gauss','average','disk','log'};

for pattern = interval
    i = 1;
    while i <= iterations
        img(:,:,:)=training_imgs(:,:,:,pattern);
        mod = false;

        %superpixel
        if rand() < 0.2
            mod = true;
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

            img = im_result;
        end

        %deform
        if rand() < 0.2
            mod = true;
            img = elasticDeformation(img, types(randi([1,4])), randi([700,1500]));
        end

        %color reduction
        if rand() < 0.2
            mod = true;
            [IND,map] = rgb2ind(img, randi([16,64]),'nodither');
            img = uint8(ind2rgb(IND,map)*255);
        end

        %pixel shuffle
        if rand() < 0.2
            mod = true;
            for k = 2: 223
                for h = 2:223
                    x = randi([-1,1]);
                    y = randi([-1,1]);
                    img(k,h,1) = img(k+x,h+y,1);
                    img(k,h,2) = img(k+x,h+y,2);
                    img(k,h,3) = img(k+x,h+y,3);
                end
            end
        end

        %content fill
        if rand() < 0.2
            mod = true;
            R = img(:,:,1);
            G = img(:,:,2);
            B = img(:,:,3);

            for k = 1: randi([2,4])
                %position and size of pasted square
                squareSizeX = randi([20,100]);
                squareX = randi([1,224-squareSizeX]);
                rangeX1 = squareX:squareX+squareSizeX;

                squareSizeY = randi([20,120]);
                squareY = randi([1,224-squareSizeY]);
                rangeY1 = squareY:squareY+squareSizeY;

                %position of copied square
                squareX = randi([1,224-squareSizeX]);
                rangeX2 = squareX:squareX+squareSizeX;

                squareY = randi([1,224-squareSizeY]);
                rangeY2 = squareY:squareY+squareSizeY;

                %assignment
                R(rangeX1,rangeY1) = R(rangeX2,rangeY2);
                G(rangeX1,rangeY1) = G(rangeX2,rangeY2);
                B(rangeX1,rangeY1) = B(rangeX2,rangeY2);
            end

            img = uint8(cat(3,R,G,B));
        end

        %Project
        if rand() < 0.2
            mod = true;
            T = [1              rand()/2-0.25    rand()/1000000;
                rand()/2-0.25      1             rand()/10000;
                rand()/100000   0             1];
            T = projective2d(T);
            img = imwarp(img,T,'FillValues',randi([0,255]));
            img = imresize(img,im_dim);
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
clearvars squareSizeX squareX rangeX1 squareSizeY squareY rangeY1 rangeX2 rangeY2 x y h k im_result
clearvars append iterations inverval his I j L Ins mod N pos types vec