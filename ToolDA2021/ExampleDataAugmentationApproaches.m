%% data getting 

clear all
close all force
warning off


siz=[224 224];%input size of ResNet50

load('DatasColor_65.mat','DATA');%to load the dataset used in this example

%the information to split data between training and test set
DIV=DATA{3};
DIM1=DATA{4};
DIM2=DATA{5};
lab=DATA{2};%label
NX=DATA{1};%cell array that stores the image

fold=1;%in this example only the first fold has been used


trainPattern=(DIV(fold,1:DIM1));%id of the training patterns
testPattern=(DIV(fold,DIM1+1:DIM2));%id of the test patterns
y=lab(DIV(fold,1:DIM1));%label of the training set
labelTE=lab(DIV(fold,DIM1+1:DIM2));%label of the test set
numClasses = max(y);

%build training set
clear nome trainingImages
for pattern=1:DIM1%for all the images 
    IM=NX{DIV(fold,pattern)};%image
    IM=imresize(IM,[siz(1) siz(2)]);
    trainingImages(:,:,:,pattern)=IM;
end
imageSize=siz;

DIM=length(y);%number of images of the training set
approccio=8;%choose the approach  <---------------------
if approccio==1%method App1 of the paper
    App1;
elseif approccio==2%method App2 of the paper
    App2;
elseif approccio==3%method App3 of the paper
    App3;
elseif approccio==4%method App4 of the paper
    [trainingImages,y]=DataAugmentation(single(trainingImages),'PCA',1,y,length(y)*0.95); %produce immagini praticamente bianche
elseif approccio==5%method App5 of the paper
    [trainingImages,y]=DataAugmentation(trainingImages,'DCT',1,y);
elseif approccio==6%method App6 of the paper
    App6;
elseif approccio==7%method App7 of the paper
    App7;
elseif approccio==8 %method App8 of the paper
    append=1;
    for pattern=1:DIM
        SourceImage(:,:,:)=trainingImages(:,:,:,pattern);
        TrueLabel=y(pattern);
        Quali=find(y==TrueLabel);
        dove=randperm(length(Quali));
        TargetImage=trainingImages(:,:,:,dove(1));
        ExtractDataAugmentation;
    end
elseif approccio==9%method App9 of the paper
    App9;
elseif approccio==10%method App10 of the paper
    [trainingImages, y] = dataAugDwt(trainingImages, y, DIM);
elseif approccio==11%method App11 of the paper
    [trainingImages, y] = dataAugCqt(trainingImages, y, DIM);
elseif approccio==12 %METODO BRAVIN
    App12;
end


%% test data creation

DIM1 = DIM1(fold);

for pattern=ceil(DIM1)+1:ceil(DIM2)
    IM=NX{DIV(fold,pattern)};
    IM=imresize(IM,[siz(1) siz(2)]);
    testImages(:,:,:,pattern-ceil(DIM1))=uint8(IM);
end

testLabel = transpose(DATA{1,2});
testLabel = testLabel(testPattern);

%% TRAINING OPTIONS


%CNN training options
metodoOptim='sgdm'; 
options = trainingOptions(metodoOptim,...
    'MiniBatchSize',30,... %30
    'MaxEpochs',6,...      %20
    'InitialLearnRate',0.001 ...
    ...%'Verbose',false,...%false
    ...%'Plots','training-progress'... %'training-progress'
    );                

%% DATA AND NETWORK MANIPULATION

%To retrain the network on a new classification task, follow the steps of Transfer Learning .
%Load the ResNet-50 model and change the names of the layers that you remove and connect
%to match the names of the ResNet-50 layers:
%         remove the 'ClassificationLayer_fc1000', 'fc1000_softmax', and 'fc1000'layers, and connect to the 'avg_pool' layer.
trainingImages = augmentedImageDatastore(imageSize,trainingImages,categorical(y));
net=resnet50;
lgraph = layerGraph(net);
lgraph = removeLayers(lgraph, {'ClassificationLayer_fc1000','fc1000_softmax','fc1000'});
newLayers = [
    fullyConnectedLayer(numClasses,'Name','fc','WeightLearnRateFactor',20,'BiasLearnRateFactor', 20)
    softmaxLayer('Name','softmax')
    classificationLayer('Name','classoutput')];
lgraph = addLayers(lgraph,newLayers);
lgraph = connectLayers(lgraph,'avg_pool','fc');

%% training

netTransfer = trainNetwork(trainingImages,lgraph,options);


%% classify

[outclass, score{fold}] =  classify(netTransfer,testImages);
accuracy = sum(double(outclass) == testLabel)/numel(outclass)