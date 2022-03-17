for pattern = interval

    img(:,:,:)=rgb2hsv(training_imgs(:,:,:,pattern));



    training_imgs(:,:,:,tr_data_sz+append) = img;
    training_lbls(tr_data_sz+append)=training_lbls(pattern);
    append = append + 1;
    i = i + 1;


end

clearvars i pattern img j vec lns

