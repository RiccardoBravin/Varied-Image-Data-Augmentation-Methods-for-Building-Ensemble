%Applies the Singular value decomposition and removes some values from it
disp("SVD reduction"),
try
    
    interval = [1:tr_data_sz];  %intervallo da cui campionare immagini

    for pattern = interval
            img(:,:,:)=training_imgs(:,:,:,pattern);

            for j = 1 : 3
                I = double(img(:,:,j));
                [U,S,V] = svd(I);

                S(S < (max(max(S))/randi([50,100]))) = 0;

                img(:,:,j) = U*S*V';

            end

            %montage({training_imgs(:,:,:,pattern),uint8(img)}); pause(1);

            training_imgs(:,:,:,end+1) = uint8(img);
            training_lbls(end+1)=training_lbls(pattern);
    end

catch ERROR
    ERROR
    disp("\nSomething went wrong inside the augmentation\nTo restore the training set use the backup training_imgs_bk and lables\n");
    keyboard;
end

clearvars i pattern img append iterations interval
clearvars j U S V I

