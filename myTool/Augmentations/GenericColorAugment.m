
for pattern = interval
    i = 1;
    while i <= iterations
        img(:,:,:)=training_imgs(:,:,:,pattern);
        mod = false;
        %imshow(img);
        
        %color shift
        if round(rand())
            mod = true;
            
            tform = randomAffine2d('XTranslation',[-3 3],'YTranslation',[-3 3]);
            outputView = affineOutputView(size(img),tform);
            img(:,:,1) = imwarp(img(:,:,1),tform,'OutputView',outputView);
            
            tform = randomAffine2d('XTranslation',[-3 3],'YTranslation',[-3 3]);
            outputView = affineOutputView(size(img),tform);
            img(:,:,2) = imwarp(img(:,:,2),tform,'OutputView',outputView);
            
            tform = randomAffine2d('XTranslation',[-3 3],'YTranslation',[-3 3]);
            outputView = affineOutputView(size(img),tform);
            img(:,:,3) = imwarp(img(:,:,3),tform,'OutputView',outputView);
        end
        
        %HUE jitter
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
        
        %Gaussian blur
        if round(rand())
            mod = true;
            trainingImages(:,:,:,DIM+append) = imgaussfilt(img,1+2*rand);
        end
        
        %Sharpening
        if round(rand())
            mod = true;
            img = imsharpen(img,'Radius',1,'Amount',rand()/2+1.5,'Threshold',0);
        end
        
        %Color variation
        if round(rand())
            mod = true;
            img = color_variation(img,randi([-20,20]),randi([-20,20]),randi([-20,20]));
        end
        
        %Dehaze
        if round(rand())
            mod = true;
            img = imreducehaze(img, rand()/2+0.5);
        end
        

        if mod %add the image only if it has been modified
            training_imgs(:,:,:,tr_data_sz+append) = img;
            training_lbls(tr_data_sz+append)=training_lbls(pattern);
            append = append + 1;
            i = i + 1;
        end
    end
end

clearvars i pattern tform outputView img

