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
        
        I = fft2(R);
        mag = abs(I);
        phs = angle(I);
        mag = mag .* (rand(size(mag)))*2;
        I = mag.*exp(1i.*phs);
        R = uint8(abs(ifft2(I)));
        
        I = fft2(G);
        mag = abs(I);
        phs = angle(I);
        mag = mag .* (rand(size(mag)))*2;
        I = mag.*exp(1i.*phs);
        G = uint8(abs(ifft2(I)));
        
        I = fft2(B);
        mag = abs(I);
        phs = angle(I);
        mag = mag .* (rand(size(mag)))*2;
        I = mag.*exp(1i.*phs);
        B = uint8(abs(ifft2(I)));
       
        img = uint8(cat(3,R,G,B));
        
        %montage({training_imgs(:,:,:,pattern), img}); pause(1);
        
        training_imgs(:,:,:,tr_data_sz+append) = img;
        training_lbls(tr_data_sz+append)=training_lbls(pattern);
        append = append + 1;
        i = i + 1;
    end
end

clearvars i pattern img R G B X ind

