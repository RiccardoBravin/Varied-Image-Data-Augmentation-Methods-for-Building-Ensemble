function [image]=method1cqt(im)
for i=1:3
    %apply CQT to every dimension of the image
    im = double(im);
    [CQT, f, g, fshifts] = cqt(im(:,:,i));
    d=CQT;
    %set some value of 3-dimensional CQT array to 0
    CQT(randi([0 1], size(CQT,1),size(CQT,2),size(CQT,3))==0)=0;
    %leave unmodified every value in position (1,1) for every dimension
    for k=1:(size(CQT,3))
        CQT(1,1,k)=d(1,1,k);
    end
    %inverse CQT
    image(:,:,i)= icqt(CQT, g, fshifts);
end
image=uint8(image);
    
end