%% LOADING DATA
clear all
close all force
warning off
addpath(genpath('C:\Users\NB\Documents\MATLAB\Implementazioni\NN_image_augmentation-main'))
addpath('C:\Users\NB\Documents\MATLAB\DATA');

gpuDevice(1);

datas=65;
DatasetName=datas;
metodo=5;

try load(strcat('DatasColor_',int2str(datas)),'DATA');
catch
    load(strcat('Datas_',int2str(datas)),'DATA');
end




IMGS = DATA{1}; %tutte le immagini
LBLS = DATA{2}; %tutti i label
PATS = DATA{3}; %indici per la suddivisione dei dati
DIVS = DATA{4}; %divisori per gli indici
DIM  = DATA{5}; %numero totale di immagini presenti

%% TESTING



for fold = 1:size(PATS,1)

    try
        disp(strcat("iteration ",num2str(fold)));
        automatedTraining;
        accuracy
        clearvars accuracy
        close all force
    
    catch ERRORGENERIC
        try
            ERRORGENERIC
            save(strcat('C:\Users\NB\Documents\MATLAB\Implementazioni\NN_image_augmentation-main\results\TunedAddingDatasetsAUGMENTATIONbravin_',num2str(datas),'_color_',num2str(metodo),'_',num2str(fold),'_extra.mat'),'accuracy')
            disp("Program terminated safely");
            keyboard;
            return;
        catch ERRORSAVE
            ERRORSAVE
            error("Program terminated without saving");
        end
        ERRORGENERIC
        keyboard;
        error("TERMINATED");
    end
end

