
for pattern = interval
    i = 1;
    while i <= iterations
        img(:,:,:)=training_imgs(:,:,:,pattern);
        
        distanceImage = fspecial('gaussian',size(img(:,:,1)), 30000); % crea un filtro gaussiano
        distanceImage = rescale(distanceImage,rand()/3,1); 
        distanceImage = cat(3, distanceImage, distanceImage, distanceImage);
       
        
        img = uint8(double(img) .* distanceImage);
                
        training_imgs(:,:,:,tr_data_sz+append) = img;
        training_lbls(tr_data_sz+append)=training_lbls(pattern);
        append = append + 1;
        i = i + 1;
        
    end
end

clearvars i pattern distanceImage img

