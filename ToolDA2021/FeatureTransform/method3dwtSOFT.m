function[image] = method3dwtSOFT(im,samples)
%apply DCT to every dimension of the image
for i=1:3
    [cA, cH, cV, cD] = dwt2(im(:,:,i), 'db1');
    for j=1:5
        %take every image from samples and apply DWT to every of them
        sample=samples(:,:,:,j);
        [sampleA, sampleH, sampleV, sampleD] = dwt2(sample(:,:,i), 'db1');
        [x, y] = size(cA);
        %cycle on every row and every column of original image
        for r=1:x
            for c=1:y
                %take a random coefficient, if it is higher than 0.95, set
                %the element in position (r,c) to the corresponding element in
                %position (r,c) of the sample
                coeff = rand();
                if coeff>=0.975
                    cA(r,c)=sampleA(r,c);
                    cH(r,c)=sampleH(r,c);
                    cV(r,c)=sampleV(r,c);
                    cD(r,c)=sampleD(r,c);
                end
            end
        end
    end
    %inverse DWT
    image(:,:,i) = idwt2(cA, cH, cV, cD, 'db1');
end
%resize because DWT returns an image with the right dimension 
siz=size(im);
image =imresize(image,[siz(1) siz(2)]);
image=uint8(image);                 
                

end