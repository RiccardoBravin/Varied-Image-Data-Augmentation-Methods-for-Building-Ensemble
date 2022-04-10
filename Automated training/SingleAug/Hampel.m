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

            LR = [];
            LG = [];
            LB = [];

            for i = 1:size(R,1)
                LR = [LR,R(i,:)];
                LG = [LG,G(i,:)];
                LB = [LB,B(i,:)];
            end

            LR = hampel(LR,10,0.8);
            LG = hampel(LG,10,0.8);
            LB = hampel(LB,10,0.8);

            for i = 1:size(R,1)
                R(i,:) = LR((i-1)*size(R,1)+ 1: i*size(R,1));
                G(i,:) = LG((i-1)*size(R,1)+ 1: i*size(R,1));
                B(i,:) = LB((i-1)*size(R,1)+ 1: i*size(R,1));
            end

            img = uint8(rescale(cat(3,R,G,B),0,255));
            %montage({training_imgs(:,:,:,pattern), img}); pause(1);

            training_imgs(:,:,:,tr_data_sz+append) = img;
            training_lbls(tr_data_sz+append)=training_lbls(pattern);
            append = append + 1;
            i = i + 1;
        end
    end

catch ERROR
    ERROR
    disp("\nDataset could be corrupted, restore it with the training_imgs_bk and lables\n");
    keyboard;
end

clearvars i pattern img R G B LR LG LB

