append=1;%da dove partire a inserire immagini
iterations = 1; %cambiare prima di ogni chiamata a file per modificare il numero di immagini generate
interval = [1:tr_data_sz];%intervallo da cui campionare immagini

types = {'gauss','average','disk','log'};

for pattern = interval
    i = 1;
    while i <= iterations
        img(:,:,:)=training_imgs(:,:,:,pattern);
        mod = false;

        %vignetting
        if rand() < 0.1
            mod = true;
            distanceImage = fspecial('gaussian',size(img(:,:,1)), 30000); % crea un filtro gaussiano
            distanceImage = rescale(distanceImage,rand()/3,1);
            distanceImage = cat(3, distanceImage, distanceImage, distanceImage);
            img = uint8(double(img) .* distanceImage);
        end

        %dehaze
        if rand() < 0.1
            mod = true;
            img = imreducehaze(img, rand()/2+0.5);
        end

        %deform
        if rand() < 0.5
            mod = true;
            img = elasticDeformation(img, types(randi([1,4])), randi([700,1500]));
        end

        %color variation
        if rand() < 0.2
            mod = true;
            img = color_variation(img, randi([-40,40]),randi([-40,40]),randi([-40,40]));
        end


        %denoise
        if rand() < 0.2
            mod = true;
            R = medfilt2(img(:,:,1));
            G = medfilt2(img(:,:,2));
            B = medfilt2(img(:,:,3));

            img = cat(3,R,G,B);
        end

        %color reduction
        if rand() < 0.2
            mod = true;
            [IND,map] = rgb2ind(img, randi([16,64]),'nodither');
            img = uint8(ind2rgb(IND,map)*255);
        end


        %project
        if rand() < 0.2
            mod = true;
            T = [1              rand()/2-0.25 rand()/1000000;
                rand()/2-0.25   1             rand()/10000;
                rand()/100000   0             1];
            T = projective2d(T);
            img = imwarp(img,T,'FillValues',randi([0,255]));
            img = imresize(img,im_dim);
        end

        %superpixel
        if rand() < 0.1
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

        %RandXReflection
        if rand() < 0.2
            mod = true;
            img = flip(img,1);
        end

        %RandYReflection
        if rand() < 0.2
            mod = true;
            img = flip(img,2);
        end

        %negative
        if rand() < 0.05
            mod = true;
            img(:,:,:)= 255 - training_imgs(:,:,:,pattern);
        end

        %channel removal
        if rand() < 0.01
            mod = true;
            img(:,:,randi([1,3])) = 0;
        end


        %random erasing
        if rand() < 0.1
            mod = true;

            vec = im_dim/2;
            lns = vec;

            for j = 1 : randi([500,2000])

                vec = vec + normrnd(0,4,1,2);
                lns(j,3:4) = vec;
                lns(j+1,1:2) = vec;

            end
            lns(j+1,3:4) = vec;

            img = insertShape(img,'line',lns,'LineWidth',5,"Color","black");
        end

        %histogram equalization
        if rand() < 0.2
            mod = true;
            his = imhist(training_imgs(:,:,:,randi([interval(1), interval(length(interval))])));
            img = histeq(img,his);
        end

        %hue jitter
        if rand() < 0.3
            mod = true;
            img = jitterColorHSV(img,'Hue',[0.05 0.15]);
        end

        %Saturation jitter
        if rand() < 0.3
            mod = true;
            img = jitterColorHSV(img,'Saturation',[-0.4 -0.1]);
        end

        %Brightness jitter
        if rand() < 0.3
            mod = true;
            img = jitterColorHSV(img,'Brightness',[-0.3 -0.1]);
        end

        %Contrast jitter
        if rand() < 0.3
            mod = true;
            img = jitterColorHSV(img,'Contrast',[1.2 1.4]);
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


