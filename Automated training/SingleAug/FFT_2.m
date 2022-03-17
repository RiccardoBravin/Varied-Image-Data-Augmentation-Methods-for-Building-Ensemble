append = 1;%da dove partire a inserire immagini
iterations = 2; %cambiare prima di ogni chiamata a file per modificare il numero di immagini generate
interval = [1:tr_data_sz];%intervallo da cui campionare immagini

for pattern = interval
    
    img(:,:,:)=training_imgs(:,:,:,pattern);
    R = img(:,:,1);
    G = img(:,:,2);
    B = img(:,:,3);
    
    %noise = zeros(size(R), 'like', 1+1i);
    %noise = 100000*imnoise(noise,'salt & pepper',0.0005);
    
    X = ((fft2(R)));
    X = (imag(X)+real(X));
    R = (uint8(rescale(abs(fft2(X)),0,255)));
    
    X = ((fft2(G)));
    X = (imag(X)+real(X));
    G = (uint8(rescale(abs(fft2(X)),0,255)));
    
    X = ((fft2(B)));
    X = (imag(X)+real(X));
    B = (uint8(rescale(abs(fft2(X)),0,255)));
    
    img = uint8(cat(3,R,G,B));
    
    montage({training_imgs(:,:,:,pattern), img}); pause(1);
    
    training_imgs(:,:,:,tr_data_sz+append) = img;
    training_lbls(tr_data_sz+append)=training_lbls(pattern);
    append = append + 1;
    
end

clearvars i pattern img R G B X ind

