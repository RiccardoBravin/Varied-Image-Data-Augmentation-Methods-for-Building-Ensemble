function[image] = method3cqt(im,samples)
%apply DCT to every dimension of the image
for i=1:3
    im = double(im);
    [CQT, f, g, fshifts] = cqt(im(:,:,i));
    for j=1:5
        %take every image from samples and apply DCT to every of them
        sample=samples(:,:,:,j);
        sample = double(sample);
        [sampleCQT, sf, sg, sfshifts] = cqt(sample(:,:,i));
        [x,y,z] = size(CQT);
        %cycle on every row and every column for every dimension of multi
        %dimensional array CQT
        for d=1:z
            for r=1:x
                for c=1:y
                    %take random coefficient, if it is higher than 0.95, set
                    %the value in position (r,c,d) to the corresponding value in
                    %position (r,c,d) of the sample
                    coeff = rand();
                    if coeff>=0.95
                        CQT(r,c,d)=sampleCQT(r,c,d);
                    end
                end
            end
        end
    end
    %inverse CQT
    image(:,:,i)= icqt(CQT, g, fshifts);
end
image=uint8(image);                 
                

end