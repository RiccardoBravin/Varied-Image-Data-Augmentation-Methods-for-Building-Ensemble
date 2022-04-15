try

    append=1;%da dove partire a inserire immagini
    iterations = 1; %cambiare prima di ogni chiamata a file per modificare il numero di immagini generate
    interval = [1:tr_data_sz]; %intervallo da cui campionare immagini

    types = {'gauss','average','disk'};

    for pattern = interval
        i = 1;
        img(:,:,:) = training_imgs(:,:,:,pattern);
        while i <= iterations
            
            %DCT
            R = dct2(img(:,:,1));
            G = dct2(img(:,:,2));
            B = dct2(img(:,:,3));

            R = uint8(rescale(dct2(R),0,255));
            G = uint8(rescale(dct2(G),0,255));
            B = uint8(rescale(dct2(B),0,255));

            R = histeq(imreducehaze(R));
            G = histeq(imreducehaze(G));
            B = histeq(imreducehaze(B));

            im_result = uint8(cat(3,R,G,B));

            training_imgs(:,:,:,tr_data_sz+append) = im_result;
            training_lbls(tr_data_sz+append)=training_lbls(pattern);
            append = append + 1;

            %deform
            training_imgs(:,:,:,tr_data_sz+append) = elasticDeformation(img, types(randi([1,3])), randi([1200,1800]));
            training_lbls(tr_data_sz+append)=training_lbls(pattern);
            append = append + 1;

            

            i = i + 1;
        end
    end
    
catch ERROR
    ERROR;
    disp("\nDataset could be corrupted, restore it with the training_imgs_bk and lables\n");
    keyboard;
end
clearvars i pattern img T distanceImage IND map redIdx greenIdx blueIdx im_result idx R G B
clearvars squareSizeX squareX rangeX1 squareSizeY squareY rangeY1 rangeX2 rangeY2 x y h k im_result
clearvars append iterations inverval his I j L Ins mod N pos types vec
