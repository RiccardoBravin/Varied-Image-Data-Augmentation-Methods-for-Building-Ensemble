append=1;
for pattern=1:DIM

    imOriginal(:,:,:)=trainingImages(:,:,:,pattern);

    %RandXReflection
    tform = randomAffine2d('XReflection',true);
    outputView = affineOutputView(size(imOriginal),tform);
    imAugmented = imwarp(imOriginal,tform,'OutputView',outputView);
    trainingImages(:,:,:,DIM+append) = imAugmented;
    y(DIM+append)=y(pattern);
    append=append+1;

    %RandYReflection
    tform = randomAffine2d('YReflection',true);
    outputView = affineOutputView(size(imOriginal),tform);
    imAugmented = imwarp(imOriginal,tform,'OutputView',outputView);
    trainingImages(:,:,:,DIM+append) = imAugmented;
    y(DIM+append)=y(pattern);
    append=append+1;

    %RandScale
    tform = randomAffine2d('Scale',[1,1.2]);
    outputView = affineOutputView(size(imOriginal),tform);
    imAugmented = imwarp(imOriginal,tform,'OutputView',outputView);
    trainingImages(:,:,:,DIM+append) = imAugmented;
    y(DIM+append)=y(pattern);
    append=append+1;

    %RandRotation
    tform = randomAffine2d('Rotation',[-10 10]);
    outputView = affineOutputView(size(imOriginal),tform);
    imAugmented = imwarp(imOriginal,tform,'OutputView',outputView);
    trainingImages(:,:,:,DIM+append) = imAugmented;
    y(DIM+append)=y(pattern);
    append=append+1;

    %translation
    tform = randomAffine2d('XTranslation',[-5 5],'YTranslation',[-5 5]);
    outputView = affineOutputView(size(imOriginal),tform);
    imAugmented = imwarp(imOriginal,tform,'OutputView',outputView);
    trainingImages(:,:,:,DIM+append) = imAugmented;
    y(DIM+append)=y(pattern);
    append=append+1;

    %shear
    tform = randomAffine2d('XShear',[0 30],'YShear',[0 30]);
    outputView = affineOutputView(size(imOriginal),tform);
    imAugmented = imwarp(imOriginal,tform,'OutputView',outputView);
    trainingImages(:,:,:,DIM+append) = imAugmented;
    y(DIM+append)=y(pattern);
    append=append+1;
end
