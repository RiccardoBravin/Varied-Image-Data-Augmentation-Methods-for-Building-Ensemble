
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
        
        if mod %add the image only if it has been modified
            training_imgs(:,:,:,tr_data_sz+append) = img;
            training_lbls(tr_data_sz+append)=training_lbls(pattern);
            append = append + 1;
            i = i + 1;
        end
    end
end

clearvars i pattern tform outputView img

