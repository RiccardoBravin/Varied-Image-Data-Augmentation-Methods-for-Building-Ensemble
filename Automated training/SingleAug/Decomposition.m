try
    append = 1;%da dove partire a inserire immagini
    iterations = 1; %cambiare prima di ogni chiamata a file per modificare il numero di immagini generate
    interval = [1:tr_data_sz];%intervallo da cui campionare immagini

    for pattern = interval
        i = 1;
        while i <= iterations
            img(:,:,:)=training_imgs(:,:,:,pattern);

            for j = 1 : 3
                C = double(img(:,:,j));
                [U,S,V] = svd(C);

                %U = U + randi([0,2])/500;
                %V = V + randi([0,2])/500;

                S(S < (max(max(S))/randi([50,100]))) = 0;

                img(:,:,j) = U*S*V';

            end

            %img = uint8(cat(3,R,G,B));
            montage({training_imgs(:,:,:,pattern),uint8(img)}); pause(1);

            training_imgs(:,:,:,tr_data_sz+append) = uint8(img);
            training_lbls(tr_data_sz+append)=training_lbls(pattern);
            append = append + 1;
            i = i + 1;

        end
    end

catch ERROR
    ERROR;
    disp("\nDataset could be corrupted, restore it with the training_imgs_bk and lables\n");
    keyboard;
end

clearvars i j pattern img U V S

