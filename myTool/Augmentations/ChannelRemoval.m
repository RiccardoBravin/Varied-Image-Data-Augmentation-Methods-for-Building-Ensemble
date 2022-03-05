
for pattern = interval
    i = 1;
    while i <= iterations
        img(:,:,:)=training_imgs(:,:,:,pattern);
        
        img(:,:,randi([1,3])) = 0;
        
        training_imgs(:,:,:,tr_data_sz+append) = img;
        training_lbls(tr_data_sz+append)=training_lbls(pattern);
        append = append + 1;
        i = i + 1;
        
    end
end

clearvars i pattern img j

