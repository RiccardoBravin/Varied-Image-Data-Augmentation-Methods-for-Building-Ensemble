try
    append = 1;%da dove partire a inserire immagini
    iterations = 1; %cambiare prima di ogni chiamata a file per modificare il numero di immagini generate
    interval = [1:tr_data_sz];%intervallo da cui campionare immagini

    for pattern = interval
        i = 1;
        while i <= iterations
            img(:,:,:)=training_imgs(:,:,:,pattern);

            R = im2double(img(:,:,1));
            G = im2double(img(:,:,2));
            B = im2double(img(:,:,3));

            for i = 1:size(img,2)
                R(:,i) = (hilbert(R(:,i)));
                G(:,i) = (hilbert(G(:,i)));
                B(:,i) = (hilbert(B(:,i)));

            end

            R = rescale(angle(R),0,255);
            G = rescale(angle(G),0,255);
            B = rescale(angle(B),0,255);

            img = uint8(cat(3,R,G,B));
            %montage({training_imgs(:,:,:,pattern),uint8(img)}); pause(1);

            training_imgs(:,:,:,tr_data_sz+append) = img;
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

clearvars i j pattern img U V S RK RM GK GM BK BM

