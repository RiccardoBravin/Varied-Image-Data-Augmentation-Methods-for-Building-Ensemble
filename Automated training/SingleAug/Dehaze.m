try

    for pattern = interval
        i = 1;
        while i <= iterations
            img(:,:,:)=training_imgs(:,:,:,pattern);

            training_imgs(:,:,:,tr_data_sz+append) = imreducehaze(img, rand()/2+0.5);
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

clearvars i pattern tform outputView img

