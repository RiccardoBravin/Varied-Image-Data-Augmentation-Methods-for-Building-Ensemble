for pattern = interval
    i = 1;
    while i <= iterations
        img(:,:,:)=training_imgs(:,:,:,pattern);
        
        vec = im_dim/2;
        lns = vec;
        
        for j = 1 : randi([500,2000])
            
            vec = vec + normrnd(0,4,1,2);
            lns(j,3:4) = vec;
            lns(j+1,1:2) = vec;
            
        end
        lns(j+1,3:4) = vec;
        
        img = insertShape(img,'line',lns,'LineWidth',5,"Color","black");
        
        training_imgs(:,:,:,tr_data_sz+append) = img;
        training_lbls(tr_data_sz+append)=training_lbls(pattern);
        append = append + 1;
        i = i + 1;
        
    end
end

clearvars i pattern img j vec lns

