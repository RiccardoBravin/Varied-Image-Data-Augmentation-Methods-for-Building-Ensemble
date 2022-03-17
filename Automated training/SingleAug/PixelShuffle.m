append = 1;%da dove partire a inserire immagini
iterations = 1; %cambiare prima di ogni chiamata a file per modificare il numero di immagini generate
interval = [1:tr_data_sz];%intervallo da cui campionare immagini

for pattern = interval
    i = 1;
    while i <= iterations
        img(:,:,:)=training_imgs(:,:,:,pattern);
        
        for k = 2: 223
            for h = 2:223
                x = randi([-1,1]);
                y = randi([-1,1]);
                img(k,h,1) = img(k+x,h+y,1);
                img(k,h,2) = img(k+x,h+y,2);
                img(k,h,3) = img(k+x,h+y,3);
            end
        end
        
        %montage({training_imgs(:,:,:,pattern), img});
        
        training_imgs(:,:,:,tr_data_sz+append) = img;
        training_lbls(tr_data_sz+append)=training_lbls(pattern);
        append = append + 1;
        i = i + 1;
        
    end
end

clearvars i pattern img x y interval append iterations h k 


