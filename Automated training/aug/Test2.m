
append=1;%da dove partire a inserire immagini
iterations = 2; %cambiare prima di ogni chiamata a file per modificare il numero di immagini generate
interval = [1:tr_data_sz];%intervallo da cui campionare immagini

types = {'gauss','average','disk','log','motion'};

for pattern = interval
    i = 1;
    while i <= iterations
        img(:,:,:)=training_imgs(:,:,:,pattern);
        mod = false;

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
        
        %hue jitter
        if round(rand())
            mod = true;
            img = jitterColorHSV(img,'Hue',[0.05 0.15]);
        end
        
        %Saturation jitter
        if round(rand())
            mod = true;
            img = jitterColorHSV(img,'Saturation',[-0.4 -0.1]);
        end
        
        %Brightness jitter
        if round(rand())
            mod = true;
            img = jitterColorHSV(img,'Brightness',[-0.3 -0.1]);
        end
        
        %Contrast jitter
        if round(rand())
            mod = true;
            img = jitterColorHSV(img,'Contrast',[1.2 1.4]);
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

        
        if mod %add the image only if it has been modified
            training_imgs(:,:,:,tr_data_sz+append) = img;
            training_lbls(tr_data_sz+append)=training_lbls(pattern);
            append = append + 1;
            i = i + 1;
        end
    end
end

clearvars i pattern img T distanceImage IND map redIdx greenIdx blueIdx im_result idx R G B 

