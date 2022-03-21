append = 1;%da dove partire a inserire immagini
iterations = 1; %cambiare prima di ogni chiamata a file per modificare il numero di immagini generate
interval = [1:tr_data_sz];%intervallo da cui campionare immagini

for pattern = interval
    i = 1;
    while i <= iterations
        img(:,:,:)=training_imgs(:,:,:,pattern);
        
        %color shift
        tform = randomAffine2d('XTranslation',[-5 5],'YTranslation',[-5 5]);
        outputView = affineOutputView(size(img),tform);
        img(:,:,1) = imwarp(img(:,:,1),tform,'OutputView',outputView);
        
        tform = randomAffine2d('XTranslation',[-5 5],'YTranslation',[-5 5]);
        outputView = affineOutputView(size(img),tform);
        img(:,:,2) = imwarp(img(:,:,2),tform,'OutputView',outputView);
        
        tform = randomAffine2d('XTranslation',[-5 5],'YTranslation',[-5 5]);
        outputView = affineOutputView(size(img),tform);
        img(:,:,3) = imwarp(img(:,:,3),tform,'OutputView',outputView);
        
      
        training_imgs(:,:,:,tr_data_sz+append) = img;
        training_lbls(tr_data_sz+append)=training_lbls(pattern);
        append = append + 1;
        i = i + 1;
        
    end
end

clearvars i pattern tform outputView img

