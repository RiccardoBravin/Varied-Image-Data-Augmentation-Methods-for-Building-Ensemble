for pattern = interval
    i = 1;
    while i <= iterations
        img(:,:,:)=double(training_imgs(:,:,:,pattern));
        
        for j = 1 : 3
            C = img(:,:,j);
            [U,S,V] = svd(C);
            
            %U = U + randi([0,2])/500;
            %V = V + randi([0,2])/500;
            
            S(S < (max(max(S))/randi([50,100]))) = 0;
        
            img(:,:,j) = U*S*V';
            
        end
      
        %img = uint8(cat(3,R,G,B));
        %montage({training_imgs(:,:,:,pattern),uint8(img)});
        
        training_imgs(:,:,:,tr_data_sz+append) = uint8(img);
        training_lbls(tr_data_sz+append)=training_lbls(pattern);
        append = append + 1;
        i = i + 1;
        
    end
end

clearvars i j pattern img U V S

