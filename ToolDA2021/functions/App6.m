append=1;
shifting_color = [ 20, -20,  5, 50, 50;
    -20,  20,  0,  0, 0;
    20,  20, 50, -10, -100];
for pattern=1:DIM
    %add contrast
    trainingImages(:,:,:,DIM+append) = add_contrast(trainingImages(:,:,:,pattern),[0.3 0.7],[]);
    y(DIM+append)=y(pattern);
    append=append+1;

    %add sharpness
    trainingImages(:,:,:,DIM+append) = add_sharpness(trainingImages(:,:,:,pattern),2);
    y(DIM+append)=y(pattern);
    append=append+1;

    %color shifting
    OtherIMG=randperm(5);
    trainingImages(:,:,:,DIM+append) = color_shifting(trainingImages(:,:,:,pattern), shifting_color(1,OtherIMG(1)),...
        shifting_color(2,OtherIMG(1)), shifting_color(3,OtherIMG(1)));
    y(DIM+append)=y(pattern);
    append=append+1;
end