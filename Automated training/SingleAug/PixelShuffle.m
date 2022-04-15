%Randomizes the pixels of the image in a 3x3 grid 
disp("Pixel Shuffle");
try
    interval = [1:tr_data_sz];  %intervallo da cui campionare immagini

    for pattern = interval
            img(:,:,:)=training_imgs(:,:,:,pattern);

            for k = 2: 223
                for h = 2:223
                    x = randi([-1,1]);
                    y = randi([-1,1]);
                    img(k,h,1) = img(k+x,h+y,1);
                    img(k,h,2) = img(k+x,h+y,2);
                    img(k,h,3) = img(k+x,h+y,3);
                end
            end

            %montage({training_imgs(:,:,:,pattern), img});

            training_imgs(:,:,:,end+1) = img;
            training_lbls(end+1)=training_lbls(pattern);
            
    end

catch ERROR
    ERROR
    disp("\nSomething went wrong inside the augmentation\nTo restore the training set use the backup training_imgs_bk and lables\n");
    keyboard;
end

clearvars i pattern img append iterations interval
clearvars h k x y