try

    append = 1;%da dove partire a inserire immagini
    iterations = 1; %cambiare prima di ogni chiamata a file per modificare il numero di immagini generate
    interval = [1:tr_data_sz];%intervallo da cui campionare immagini


    for pattern = interval
        i = 1;
        img(:,:,:)=training_imgs(:,:,:,pattern);
        while i <= iterations

            outImg = flipdim(img ,1);
            training_imgs(:,:,:,tr_data_sz+append) = outImg;
            training_lbls(tr_data_sz+append)=training_lbls(pattern);
            append = append + 1;

            outImg = flipdim(img ,2);
            training_imgs(:,:,:,tr_data_sz+append) = outImg;
            training_lbls(tr_data_sz+append)=training_lbls(pattern);
            append = append + 1;

            outImg = imresize(imrotate(img, randi([0,180])),im_dim);

            training_imgs(:,:,:,tr_data_sz+append) = outImg;
            training_lbls(tr_data_sz+append)=training_lbls(pattern);
            append = append + 1;

            outImg = imnoise(img,"gaussian");
            training_imgs(:,:,:,tr_data_sz+append) = outImg;
            training_lbls(tr_data_sz+append)=training_lbls(pattern);
            append = append + 1;

            outImg = imresize(imcrop(img,[randi([0,20]),randi([0,20]),randi([200,224]),randi([200,224])]),im_dim);
            training_imgs(:,:,:,tr_data_sz+append) = outImg;
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

clearvars i pattern img his

