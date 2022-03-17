append = 1;%da dove partire a inserire immagini
iterations = 2; %cambiare prima di ogni chiamata a file per modificare il numero di immagini generate
interval = [1:tr_data_sz];%intervallo da cui campionare immagini

for pattern = interval
    i = 1;
    while i <= iterations
        img(:,:,:)=training_imgs(:,:,:,pattern);

        T = [1              rand()/2-0.25    rand()/1000000;
            rand()/2-0.25      1             rand()/10000;
            rand()/100000   0             1];
        T = projective2d(T);
        img = imwarp(img,T,'FillValues',randi([0,255]));
        img = imresize(img,im_dim);

        %montage({training_imgs(:,:,:,pattern), img});pause(1);
        
        training_imgs(:,:,:,tr_data_sz+append) = img;
        training_lbls(tr_data_sz+append)=training_lbls(pattern);
        append = append + 1;
        i = i + 1;

    end
end

clearvars i pattern img append iterations interval T

