%% LOADING DATA
clear all
close all force
warning off

load('paintings.mat','DATA');%to load the dataset used in this example

IMGS = DATA{1}; %tutte le immagini
LBLS = DATA{2}; %tutti i label
PATS = DATA{3}; %indici per la suddivisione dei dati
DIVS = DATA{4}; %divisori per gli indici
DIM = DATA{5};  %numero totale di immagini presenti
%% DATA MANIPULATION
im_dim=[224 224];%input size of ResNet50
fold = 1; %DECIDI QUALE FOLD UTILIZZARE PER GLI INDICI
num_classes = max(LBLS); %numero di classi di dati
tr_data_sz = DIVS(fold); %numero di immagini per il training

training_imgs = zeros(im_dim(1), im_dim(2), 3, tr_data_sz, 'uint8'); %inizializzazione dello spazio di memoria  
for pattern = 1:tr_data_sz              %for all the images of training
    I=IMGS{PATS(fold,pattern)};         %image for the training
    I=imresize(I,im_dim);               %resize image
    training_imgs(:,:,:,pattern) = I;   %add to the training images
end

training_lbls = LBLS(PATS(fold,1:tr_data_sz)); %lables for the training images
training_lbls = categorical(training_lbls);

test_imgs = zeros(im_dim(1), im_dim(2), 3, DIM - tr_data_sz, 'uint8'); %inizializzazione dello spazio di memoria  
for pattern = tr_data_sz+1:DIM          %for all the images of test
    I=IMGS{PATS(fold,pattern)};         %image for the test
    I=imresize(I,im_dim);                   %resize image
    test_imgs(:,:,:,pattern-tr_data_sz) = I;   %add to the test images
end

test_lbls = LBLS(PATS(fold,tr_data_sz+1:DIM)); %lables for the test images
test_lbls = categorical(test_lbls);

training_imgs_bk = training_imgs;
training_lbls_bk = training_lbls;

%% TRAINING OPTIONS
options = trainingOptions('adam',...                    %sgdm
    'Plots','training-progress',...                     %training-progress
    'Verbose', false,...                                %false                          
    'MaxEpochs', 9,...                                  %20
    'MiniBatchSize', 50,...                             %30
    'Shuffle', 'every-epoch',...                        %every-epoch
    'ValidationData', {test_imgs, test_lbls},...        %
    'ValidationFrequency',30,...                        %30
    'ValidationPatience',100,...                        %5
    'InitialLearnRate',0.0001,...                       %0.001
    'LearnRateSchedule','piecewise',...                 %piecewise
    'LearnRateDropPeriod', 4 ...                        %5
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

%% TRAINING & DATA AUGMENTATION

acc_i = 1;

disp("No augmentation");
netTransfer = trainNetwork(training_imgs, training_lbls, lgraph, options); %training with modified dataset

[outclass, score{fold}] =  classify(netTransfer,test_imgs); %classification with test images

accuracy{1,acc_i} = "No augmentation";
accuracy{2,acc_i} = sum(outclass' == test_lbls)/size(test_lbls,2);
accuracy{3,acc_i} = [1:num_classes;histcounts(outclass((test_lbls' == outclass)))./histcounts(outclass)];

training_imgs = training_imgs_bk;
training_lbls = training_lbls_bk;

%% Test 1

acc_i = acc_i+1;

disp("Test 1");
Test1;
netTransfer = trainNetwork(training_imgs, training_lbls, lgraph, options); %training with modified dataset

[outclass, score{fold}] =  classify(netTransfer,test_imgs); %classification with test images

accuracy{1,acc_i} = "Deform+ColorVariation+ColorReduction+Superpixel x2";
accuracy{2,acc_i} = sum(outclass' == test_lbls)/size(test_lbls,2);
accuracy{3,acc_i} = [1:num_classes;histcounts(outclass((test_lbls' == outclass)))./histcounts(outclass)];
acc_i = acc_i+1;

training_imgs = training_imgs_bk;
training_lbls = training_lbls_bk;
%% Test 2

acc_i = acc_i+1;

disp("Test 2");
Test2;
netTransfer = trainNetwork(training_imgs, training_lbls, lgraph, options); %training with modified dataset

[outclass, score{fold}] =  classify(netTransfer,test_imgs); %classification with test images

accuracy{1,acc_i} = "ColorVariation+Denoise+Project+jitter x2";
accuracy{2,acc_i} = sum(outclass' == test_lbls)/size(test_lbls,2);
accuracy{3,acc_i} = [1:num_classes;histcounts(outclass((test_lbls' == outclass)))./histcounts(outclass)];
acc_i = acc_i+1;

training_imgs = training_imgs_bk;
training_lbls = training_lbls_bk;

%% Test 3

acc_i = acc_i+1;

disp("Test 3");
Test3;
netTransfer = trainNetwork(training_imgs, training_lbls, lgraph, options); %training with modified dataset

[outclass, score{fold}] =  classify(netTransfer,test_imgs); %classification with test images

accuracy{1,acc_i} = "Denoise+Superpixel+Deform+ColorReduction x2";
accuracy{2,acc_i} = sum(outclass' == test_lbls)/size(test_lbls,2);
accuracy{3,acc_i} = [1:num_classes;histcounts(outclass((test_lbls' == outclass)))./histcounts(outclass)];
acc_i = acc_i+1;

training_imgs = training_imgs_bk;
training_lbls = training_lbls_bk;

%% Test 4

acc_i = acc_i+1;

disp("Test 4");
Test4;
netTransfer = trainNetwork(training_imgs, training_lbls, lgraph, options); %training with modified dataset

[outclass, score{fold}] =  classify(netTransfer,test_imgs); %classification with test images

accuracy{1,acc_i} = "All x3";
accuracy{2,acc_i} = sum(outclass' == test_lbls)/size(test_lbls,2);
accuracy{3,acc_i} = [1:num_classes;histcounts(outclass((test_lbls' == outclass)))./histcounts(outclass)];
acc_i = acc_i+1;

training_imgs = training_imgs_bk;
training_lbls = training_lbls_bk;