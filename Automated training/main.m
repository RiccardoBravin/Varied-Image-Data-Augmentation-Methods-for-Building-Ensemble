%% LOADING DATA
clear all
close all force
warning off

DatasetName = "DatasColor_37.mat";

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
        disp(strcat("ITERATION ",num2str(fold)));
        automatedTraining;
        for i = 1:size(accuracy{1},2) 
            disp(strcat(accuracy{fold}{1,i}, " = ", num2str(accuracy{fold}{2,i}*100), "%"));
        end
        save(strcat(extractBefore(DatasetName,".mat"), "_accuracy.mat"),"accuracy");
        close all force
    
    catch ERRORGENERIC
        try
            disp(ERRORGENERIC)
            save(strcat(extractBefore(DatasetName,".mat"), "_accuracy.mat"),"accuracy");
            disp("Program terminated safely");
            keyboard;
        catch ERRORSAVE
            disp(ERRORSAVE)
            keyboard;
            error("Program terminated without saving");
        end
        
    end
end