%applies circular vignetting to the image
disp("Vignetting");
try
    
    interval = [1:tr_data_sz];  %intervallo da cui campionare immagini
    
    for pattern = interval
       
            img(:,:,:)=training_imgs(:,:,:,pattern);

            distanceImage = fspecial('gaussian',size(img(:,:,1)), 30000); % crea un filtro gaussiano
            distanceImage = rescale(distanceImage,rand()/3,1);
            distanceImage = cat(3, distanceImage, distanceImage, distanceImage);


            img = uint8(double(img) .* distanceImage);

            training_imgs(:,:,:,end+1) = img;
            training_lbls(end+1)=training_lbls(pattern);
            
    end

catch ERROR
    ERROR
    disp("\nSomething went wrong inside the augmentation\nTo restore the training set use the backup training_imgs_bk and lables\n");
    keyboard;
end

clearvars pattern img interval
clearvars distanceImage
