
for pattern = interval
    
    img(:,:,:)=training_imgs(:,:,:,pattern);
  
    R = medfilt2(img(:,:,1));
    G = medfilt2(img(:,:,2));
    B = medfilt2(img(:,:,3));
    
    img = cat(3,R,G,B);
    
    
    training_imgs(:,:,:,tr_data_sz+append) = img;
    training_lbls(tr_data_sz+append)=training_lbls(pattern);
    append = append + 1;
    
end

clearvars i pattern img R G B X ind

