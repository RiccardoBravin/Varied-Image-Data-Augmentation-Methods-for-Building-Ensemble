append=1;
for pattern = 1:DIM
    for i = 1:5
        img(:,:,:)=trainingImages(:,:,:,pattern);
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
            trainingImages(:,:,:,DIM+append) = img;
            y(DIM+append)=y(pattern);
            append=append+1;
            %imshow(img);
        else
            pattern = pattern - 1;
        end
    end
end

