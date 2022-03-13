
for pattern = interval
    i = 1;
    while i <= iterations
        img(:,:,:)=training_imgs(:,:,:,pattern);
        
        for i = 2: 223
            for j = 2:223
                x = randi([-1,1]);
                y = randi([-1,1]);
                img(i,j,1) = img(i+x,j+y,1);
                img(i,j,2) = img(i+x,j+y,2);
                img(i,j,3) = img(i+x,j+y,3);
            end
        end
        
        %montage({training_imgs(:,:,:,pattern), img});
        
        training_imgs(:,:,:,tr_data_sz+append) = img;
        training_lbls(tr_data_sz+append)=training_lbls(pattern);
        append = append + 1;
        i = i + 1;
        
    end
end

clearvars i pattern img R G B X ind

