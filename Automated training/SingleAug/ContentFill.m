%inserts in the image copies of random parts of itself
disp("Content fill");
try

    interval = [1:tr_data_sz];  %intervallo da cui campionare immagini

    for pattern = interval

        img(:,:,:)=training_imgs(:,:,:,pattern);
        R = img(:,:,1);
        G = img(:,:,2);
        B = img(:,:,3);

        for aux = 1: randi([2,4])
            %position and size of pasted square
            squareSizeX = randi([20,100]);
            squareX = randi([1,224-squareSizeX]);
            rangeX1 = squareX:squareX+squareSizeX;

            squareSizeY = randi([20,120]);
            squareY = randi([1,224-squareSizeY]);
            rangeY1 = squareY:squareY+squareSizeY;

            %position of copied square
            squareX = randi([1,224-squareSizeX]);
            rangeX2 = squareX:squareX+squareSizeX;

            squareY = randi([1,224-squareSizeY]);
            rangeY2 = squareY:squareY+squareSizeY;

            %assignment
            R(rangeX1,rangeY1) = R(rangeX2,rangeY2);
            G(rangeX1,rangeY1) = G(rangeX2,rangeY2);
            B(rangeX1,rangeY1) = B(rangeX2,rangeY2);
        end

        img = uint8(cat(3,R,G,B));

        %montage({training_imgs(:,:,:,pattern), img});pause(0.5);

        training_imgs(:,:,:,end+1) = img;
        training_lbls(end+1)=training_lbls(pattern);
    end

catch ERROR
    ERROR
    disp("\nSomething went wrong inside the augmentation\nTo restore the training set use the backup training_imgs_bk and lables\n");
    keyboard;
end

clearvars pattern img interval
clearvars R G B squareSizeX squareX rangeX1 squareSizeY squareY rangeY1 rangeX2 rangeY2 aux
