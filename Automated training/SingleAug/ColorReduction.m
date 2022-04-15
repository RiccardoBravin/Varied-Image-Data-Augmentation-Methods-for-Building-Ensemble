%Reduces the number of colors present in the image creating bigger
%differences between near sudden colorchanges
disp("Color reduction");

try
    interval = [1:tr_data_sz];  %intervallo da cui campionare immagini
    
    for pattern = interval
        img(:,:,:)=training_imgs(:,:,:,pattern);

        [IND,map] = rgb2ind(img, randi([6,18]),'nodither');
        img = uint8(ind2rgb(IND,map)*255);

        %montage({training_imgs(:,:,:,pattern), img});pause(0.5);

        training_imgs(:,:,:,end+1) = img;
        training_lbls(end+1)=training_lbls(pattern);
    end

catch ERROR
    ERROR
    disp("\nSomething went wrong inside the augmentation\nTo restore the training set use the backup training_imgs_bk and lables\n");
    keyboard;
end

clearvars i pattern img append iterations interval IND map

