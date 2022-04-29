%% LOADING DATA
clear all
close all force
warning off

DatasetName = "DatasColor_65.mat";

load(DatasetName,"DATA");%to load the dataset used in this example

IMGS = DATA{1}; %tutte le immagini
LBLS = DATA{2}; %tutti i label
PATS = DATA{3}; %indici per la suddivisione dei dati
DIVS = DATA{4}; %divisori per gli indici
DIM  = DATA{5}; %numero totale di immagini presenti

%% TESTING

if size(PATS,1) <= 1
    error("The number of folds in the dataset is not enough for k-fold cross validation")
end

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
            save(strcat("bark_fold", num2str(fold), "_accuracy.mat"),"accuracy");
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