%shifts the channels in random directions creating a old 3d like effect
disp("Color shift");
try

    interval = [1:tr_data_sz];  %intervallo da cui campionare immagini

    for pattern = interval

        img(:,:,:)=training_imgs(:,:,:,pattern);

        %color shift
        for plane = 1:3
            tform = randomAffine2d('XTranslation',[-5 5],'YTranslation',[-5 5]);
            outputView = affineOutputView(size(img),tform);
            img(:,:,plane) = imwarp(img(:,:,plane),tform,'OutputView',outputView);

        end

        training_imgs(:,:,:,end+1) = img;
        training_lbls(end+1)=training_lbls(pattern);

    end

catch ERROR
    ERROR
    disp("\nSomething went wrong inside the augmentation\nTo restore the training set use the backup training_imgs_bk and lables\n");
    keyboard;
end

clearvars pattern img interval plane tform outputView

