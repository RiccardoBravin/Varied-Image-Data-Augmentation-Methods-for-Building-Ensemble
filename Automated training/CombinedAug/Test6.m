try

    append=1;%da dove partire a inserire immagini
    iterations = 1; %cambiare prima di ogni chiamata a file per modificare il numero di immagini generate
    interval = [1:tr_data_sz]; %intervallo da cui campionare immagini

    types = {'gauss','average','disk','log'};

    for pattern = interval
        i = 1;
        img(:,:,:) = training_imgs(:,:,:,pattern);
        while i <= iterations

            %deform
            training_imgs(:,:,:,tr_data_sz+append) = elasticDeformation(img, types(randi([1,4])), randi([700,1500]));
            training_lbls(tr_data_sz+append)=training_lbls(pattern);
            append = append + 1;

            %color reduction
            [IND,map] = rgb2ind(img, randi([16,64]),'nodither');
            training_imgs(:,:,:,tr_data_sz+append) = uint8(ind2rgb(IND,map)*255);
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
            

            %FFT_2
            R = img(:,:,1);
            G = img(:,:,2);
            B = img(:,:,3);

            I = fft2(R);
            mag = abs(I);
            phs = angle(I);
            mag = mag .* ((rand(size(mag)))+0.5);
            I = mag.*exp(1i.*phs);
            R = uint8(abs(ifft2(I)));

            I = fft2(G);
            mag = abs(I);
            phs = angle(I);
            mag = mag .* ((rand(size(mag)))+0.5);
            I = mag.*exp(1i.*phs);
            G = uint8(abs(ifft2(I)));

            I = fft2(B);
            mag = abs(I);
            phs = angle(I);
            mag = mag .* ((rand(size(mag)))+0.5);
            I = mag.*exp(1i.*phs);
            B = uint8(abs(ifft2(I)));

            im_result = uint8(cat(3,R,G,B));
            training_imgs(:,:,:,tr_data_sz+append) = im_result;
            training_lbls(tr_data_sz+append)=training_lbls(pattern);
            append = append + 1;

            %Deconvolution
            PSF = imnoise(zeros(randi([4,8])),"gaussian", 1);
            training_imgs(:,:,:,tr_data_sz+append) = deconvblind(img,PSF);
            training_lbls(tr_data_sz+append)=training_lbls(pattern);
            append = append + 1;
            
            %laplacian
            rn = randi([1,3]);
            if rn == 1
                im_result = locallapfilt(img, rn()/2,rn()/3);
            elseif rn == 2
                im_result = locallapfilt(img, rn()/7,3,'NumIntensityLevels', randi([10,15]));
            else
                im_result = locallapfilt(img, 0.1,rn()+0.5,rn()+1);
            end
            
            training_imgs(:,:,:,tr_data_sz+append) = im_result;
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
