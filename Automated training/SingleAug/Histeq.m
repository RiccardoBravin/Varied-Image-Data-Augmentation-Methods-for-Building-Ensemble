%applies to the image the histogram of a random one
disp("Content fill");
try
    interval = [1:tr_data_sz];  %intervallo da cui campionare immagini

    for pattern = interval
        

            his = imhist(training_imgs(:,:,:,randi([1,tr_data_sz])));
            img = histeq(training_imgs(:,:,:,pattern),his);
        
            %montage({training_imgs(:,:,:,pattern), img});pause(0.5);

            training_imgs(:,:,:,end+1) = img;
            training_lbls(end+1)=training_lbls(pattern);
            
    end
catch ERROR
    ERROR
    disp("\nSomething went wrong inside the augmentation\nTo restore the training set use the backup training_imgs_bk and lables\n");
    keyboard;
end

clearvars pattern img  interval
clearvars his