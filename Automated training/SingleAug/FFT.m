
try

    append = 1;%da dove partire a inserire immagini
    iterations = 2; %cambiare prima di ogni chiamata a file per modificare il numero di immagini generate
    interval = [1:tr_data_sz];%intervallo da cui campionare immagini

    for pattern = interval
        i = 1;
        while i <= iterations
            img(:,:,:)=training_imgs(:,:,:,pattern);
            R = img(:,:,1);
            G = img(:,:,2);
            B = img(:,:,3);

            %noise = zeros(size(R), 'like', 1+1i);
            %noise = 100000*imnoise(noise,'salt & pepper',0.0005);

            X = ((fft2(R)));
            ind = logical((X < randi([500,1000])) .* (X > randi([-1000,-500])));
            X(ind) = 0;
            %imagesc(log(abs(X)));
            R = (uint8(rescale(abs(fft2(X)),0,255)));

            X = ((fft2(G)));
            ind = logical((X < randi([500,1000])) .* (X > randi([-1000,-500])));
            X(ind) = 0;
            G = (uint8(rescale(abs(fft2(X)),0,255)));

            X = ((fft2(B)));
            ind = logical((X < randi([500,1000])) .* (X > randi([-1000,-500])));
            X(ind) = 0;
            B = (uint8(rescale(abs(fft2(X)),0,255)));

            img = uint8(cat(3,R,G,B));

            montage({training_imgs(:,:,:,pattern), img}); pause(1);

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


clearvars i pattern img R G B X ind

