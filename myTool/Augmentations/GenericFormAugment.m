
for pattern = interval
    i = 1;
    while i <= iterations
        img(:,:,:)=training_imgs(:,:,:,pattern);
        mod = false;
        %imshow(img);
        
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
            tform = randomAffine2d('XShear',[0 10],'YShear',[0 10]);
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

clearvars i pattern tform outputView img

