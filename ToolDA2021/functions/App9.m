%elastic distortion
append=1;
for pattern=1:DIM
    IM(:,:,:)=trainingImages(:,:,:,pattern);

    trainingImages(:,:,:,DIM+append) =elastic_deformationKU(IM,7000);
    AddLabel;
    trainingImages(:,:,:,DIM+append) =elastic_deformationKU(IM,10000);
    AddLabel;
    trainingImages(:,:,:,DIM+append) =elastic_deformationKU(IM,13000);
    AddLabel;
    trainingImages(:,:,:,DIM+append) = ElasticDeformationSC(IM, 'gauss', 3000);
    AddLabel;
    trainingImages(:,:,:,DIM+append) = ElasticDeformationSC(IM, 'disk', 3000);
    AddLabel;
    trainingImages(:,:,:,DIM+append) = ElasticDeformationSC(IM, 'log', 3000);
    AddLabel;
end