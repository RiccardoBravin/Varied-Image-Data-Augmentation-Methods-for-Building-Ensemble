%Deforms the image with an elastic deformation
disp("Elastic deformation");
try

    interval = [1:tr_data_sz];  %intervallo da cui campionare immagini

    types = {'gauss','average','disk'};

    for pattern = interval
        
            img(:,:,:)=training_imgs(:,:,:,pattern);
                                
            img = elasticDeformation(img,types(randi([1,3])) , randi([1200,1800]));

            %montage({training_imgs(:,:,:,pattern), img});pause(0.5);

            training_imgs(:,:,:,end+1) = img;
            training_lbls(end+1)=training_lbls(pattern);
            
    end

catch ERROR
    ERROR
    disp("\nSomething went wrong inside the augmentation\nTo restore the training set use the backup training_imgs_bk and lables\n");
    keyboard;
end

clearvars pattern img interval
clearvars types
