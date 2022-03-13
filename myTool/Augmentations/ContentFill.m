
for pattern = interval
    i = 1;
    while i <= iterations
        img(:,:,:)=training_imgs(:,:,:,pattern);
        R = img(:,:,1);
        G = img(:,:,2);
        B = img(:,:,3);
        
        for aux = 1: randi([2,4])
            %position and size of pasted square
            squareSizeX = randi([20,120]);
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
        
        %montage({training_imgs(:,:,:,pattern), img});
        
        training_imgs(:,:,:,tr_data_sz+append) = img;
        training_lbls(tr_data_sz+append)=training_lbls(pattern);
        append = append + 1;
        i = i + 1;
        
    end
end

clearvars i pattern img R G B squareSizeX squareX rangeX1 squareSizeY squareY rangeY1 rangeX2 rangeY2

