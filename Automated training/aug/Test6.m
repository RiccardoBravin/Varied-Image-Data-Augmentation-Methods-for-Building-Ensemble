
append=1;%da dove partire a inserire immagini
iterations = 2; %cambiare prima di ogni chiamata a file per modificare il numero di immagini generate
interval = [1:tr_data_sz];%intervallo da cui campionare immagini

types = {'gauss','average','disk','log','motion'};

for pattern = interval
    i = 1;
    while i <= iterations
        img(:,:,:)=training_imgs(:,:,:,pattern);
        mod = false;

        %vignetting
        if rand() < 0.5
            mod = true;
            distanceImage = fspecial('gaussian',size(img(:,:,1)), 30000); % crea un filtro gaussiano
            distanceImage = rescale(distanceImage,rand()/3,1);
            distanceImage = cat(3, distanceImage, distanceImage, distanceImage);
            img = uint8(double(img) .* distanceImage);
        end

        %dehaze
        if rand() < 0.5
            mod = true;
            img = imreducehaze(img, rand()/2+0.5);
        end

        %color variation
        if rand() < 0.5
            mod = true;
            img = color_variation(img, randi([-40,40]),randi([-40,40]),randi([-40,40]));
        end


        %color reduction
        if rand() < 0.5
            mod = true;
            [IND,map] = rgb2ind(img, randi([16,64]),'nodither');
            img = uint8(ind2rgb(IND,map)*255);
        end


        %negative
        if rand() < 0.1
            mod = true;
            img(:,:,:)= 255 - training_imgs(:,:,:,pattern);
        end

        %channel removal
        if rand() < 0.1
            mod = true;
            img(:,:,randi([1,3])) = 0;
        end

        %histogram equalization
        if rand() < 0.4
            mod = true;
            his = imhist(training_imgs(:,:,:,randi([interval(1), interval(length(interval))])));
            img = histeq(img,his);
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

