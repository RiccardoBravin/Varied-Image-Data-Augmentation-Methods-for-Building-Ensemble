
append=1;%da dove partire a inserire immagini
iterations = 1; %cambiare prima di ogni chiamata a file per modificare il numero di immagini generate
interval = [1:tr_data_sz]; %intervallo da cui campionare immagini

types = {'gauss','average','disk','log'};

for pattern = interval
    i = 1;
    img(:,:,:) = training_imgs(:,:,:,pattern);
    while i <= iterations
        
        %ContentFill
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
        training_imgs(:,:,:,tr_data_sz+append) = uint8(cat(3,R,G,B));
        training_lbls(tr_data_sz+append)=training_lbls(pattern);
        append = append + 1;
        
        %colorspace change
        training_imgs(:,:,:,tr_data_sz+append) = rgb2yiq(img);
        training_lbls(tr_data_sz+append)=training_lbls(pattern);
        append = append + 1;

        %Project
        T = [1              rand()/2-0.25    rand()/1000000;
            rand()/2-0.25      1             rand()/10000;
            rand()/100000   0             1];
        T = projective2d(T);
        im_result = imwarp(img,T,'FillValues',randi([0,255]));
        im_result = imresize(im_result,im_dim);
        training_imgs(:,:,:,tr_data_sz+append) = im_result;
        training_lbls(tr_data_sz+append)=training_lbls(pattern);
        append = append + 1;

        i = i + 1;
    end
end

clearvars i pattern img T distanceImage IND map redIdx greenIdx blueIdx im_result idx R G B 
clearvars squareSizeX squareX rangeX1 squareSizeY squareY rangeY1 rangeX2 rangeY2 x y h k im_result
clearvars append iterations inverval his I j L Ins mod N pos types vec
