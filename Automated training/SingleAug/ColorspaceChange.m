append=1;%da dove partire a inserire immagini
iterations = 1; %cambiare prima di ogni chiamata a file per modificare il numero di immagini generate
interval = [1:tr_data_sz];%intervallo da cui campionare immagini

for pattern = interval

    img(:,:,:)=rgb2yiq(training_imgs(:,:,:,pattern));

    training_imgs(:,:,:,tr_data_sz+append) = img;
    training_lbls(tr_data_sz+append)=training_lbls(pattern);
    append = append + 1;
    i = i + 1;


end

clearvars i pattern img j vec lns

