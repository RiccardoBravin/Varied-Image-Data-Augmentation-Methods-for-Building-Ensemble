append = 1;%da dove partire a inserire immagini
iterations = 1; %cambiare prima di ogni chiamata a file per modificare il numero di immagini generate
interval = [1:tr_data_sz];%intervallo da cui campionare immagini

for pattern = interval
    i = 1;
    while i <= iterations
        img(:,:,:)=training_imgs(:,:,:,pattern);
        
        R = dct2(img(:,:,1));
        G = dct2(img(:,:,2));
        B = dct2(img(:,:,3));
        
        R(abs(R) < randi([0,20])) = 0;
        G(abs(G) < randi([0,20])) = 0;
        G(abs(G) < randi([0,20])) = 0;
        
        R = rescale(dct2(R),0,255);
        G = rescale(dct2(G),0,255);
        B = rescale(dct2(B),0,255);
        
        img = uint8(cat(3,R,G,B));
        
        montage({training_imgs(:,:,:,pattern), img});pause(1);

        training_imgs(:,:,:,tr_data_sz+append) = img;
        training_lbls(tr_data_sz+append)=training_lbls(pattern);
        append = append + 1;
        i = i + 1;
        
    end
end

clearvars i pattern img R G B

