%% LOADING DATA

clear all
close all force
warning off

load('DatasColor_37.mat','DATA');%to load the dataset used in this example
%load('Single.mat','DATA');

IMGS = DATA{1}; %tutte le immagini
LBLS = DATA{2}; %tutti i label
PATS = DATA{3}; %indici per la suddivisione dei dati
DIVS = DATA{4}; %divisori per gli indici
DIM = DATA{5};  %numero totale di immagini presenti

%% DATA MANIPULATION

im_dim=[224 224];%input size of ResNet50
fold = 1; %DECIDI QUALE FOLD UTILIZZARE PER GLI INDICI
num_classes = max(LBLS); %numero di classi di dati

if(size(DIVS) == size(PATS,1))
    tr_data_sz = DIVS(fold); %numero di immagini per il training
else
    tr_data_sz = DIVS(1); %numero di immagini per il training
end

training_imgs = zeros(im_dim(1), im_dim(2), 3, tr_data_sz, 'uint8'); %inizializzazione dello spazio di memoria  
for pattern = 1:tr_data_sz %for all the images of training
    I=IMGS{PATS(fold,pattern)};         %image for the training
    I=imresize(I,im_dim);               %resize image
    training_imgs(:,:,:,pattern) = I;   %add to the training images
end

training_lbls = LBLS(PATS(fold,1:tr_data_sz)); %lables for the training images
training_lbls = categorical(training_lbls);

test_imgs = zeros(im_dim(1), im_dim(2), 3, DIM - tr_data_sz, 'uint8'); %inizializzazione dello spazio di memoria  
for pattern = tr_data_sz+1:DIM %for all the images of test
    I=IMGS{PATS(fold,pattern)};         %image for the test
    I=imresize(I,im_dim);               %resize image
    test_imgs(:,:,:,pattern-tr_data_sz) = I;   %add to the test images
end

test_lbls = LBLS(PATS(fold,tr_data_sz+1:DIM)); %lables for the test images
test_lbls = categorical(test_lbls);

%% TRAINING OPTIONS

options = trainingOptions('adam',...                    %sgdm
    'Plots','training-progress',...                     %training-progress
    'Verbose', false,...                                %false                          
    'MaxEpochs', 10,...                                  %20
    'MiniBatchSize', 50,...                             %30
    'Shuffle', 'every-epoch',...                        %every-epoch
    'ValidationData', {test_imgs, test_lbls},...        %
    'ValidationFrequency',30,...                        %30
    'ValidationPatience',20,...                        %5
    'InitialLearnRate',0.0001,...                       %0.001
    'LearnRateSchedule','piecewise',...                 %piecewise
    'LearnRateDropPeriod', 7 ...                        %5
);

%% NETWORK MANIPULATION

%To retrain the network on a new classification task, follow the steps of Transfer Learning .
%Load the ResNet-50 model and change the names of the layers that you remove and connect
%to match the names of the ResNet-50 layers:
%remove the 'ClassificationLayer_fc1000', 'fc1000_softmax', and 'fc1000'layers, and connect to the 'avg_pool' layer.

lgraph = layerGraph(resnet18); %Scelta del network da utilizzare
lgraph = removeLayers(lgraph, {'ClassificationLayer_predictions','prob','fc1000'});
newLayers = [
    fullyConnectedLayer(num_classes,'Name','fc','WeightLearnRateFactor',20,'BiasLearnRateFactor', 20)
    softmaxLayer('Name','softmax')
    classificationLayer('Name','classoutput')];
lgraph = addLayers(lgraph,newLayers);
lgraph = connectLayers(lgraph,'pool5','fc');

% lgraph = layerGraph(resnet50); %Scelta del network da utilizzare
% lgraph = removeLayers(lgraph, {'ClassificationLayer_fc1000','fc1000_softmax','fc1000'});
% newLayers = [
%     fullyConnectedLayer(num_classes,'Name','fc','WeightLearnRateFactor',20,'BiasLearnRateFactor', 20)
%     softmaxLayer('Name','softmax')
%     classificationLayer('Name','classoutput')];
% lgraph = addLayers(lgraph,newLayers);
% lgraph = connectLayers(lgraph,'avg_pool','fc');

acc_i = 1;
%% TRAINING

disp("Hi")
CascadeAll;

netTransfer = trainNetwork(training_imgs, training_lbls, lgraph, options);

[outclass, score{fold}] =  classify(netTransfer,test_imgs);

accuracy{1,acc_i} = "All x2";
accuracy{2,acc_i} = sum(outclass' == test_lbls)/size(test_lbls,2);
accuracy{3,acc_i} = [1:num_classes;histcounts(outclass((test_lbls' == outclass)))./histcounts(outclass)];

acc_i = acc_i+1;

% %% Checking features
% 
% img = training_imgs(:,:,:,1);
% Y = classify(netTransfer,img);
% 
% map = imageLIME(netTransfer,img,Y);
% imshow(img,'InitialMagnification',150)
% hold on
% imagesc(map,'AlphaData',0.5)
% colormap jet
% colorbar
% 
% hold off
% %% checking 2
% img = test_imgs(:,:,:,1);
% Y = classify(netTransfer,img);
% map = imageLIME(netTransfer,img,Y, ...
%     "Segmentation","grid",...
%     "OutputUpsampling","bicubic",...
%     "NumFeatures",100,...
%     "NumSamples",6000,...
%     "Model","linear");
% 
% imshow(img,'InitialMagnification', 150)
% hold on
% imagesc(map,'AlphaData',0.5)
% colormap jet
% colorbar
% hold off