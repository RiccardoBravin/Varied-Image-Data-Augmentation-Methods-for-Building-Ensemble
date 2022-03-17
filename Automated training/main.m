%% LOADING DATA
clear all
close all force
warning off

load('DatasColor_65.mat','DATA');%to load the dataset used in this example

IMGS = DATA{1}; %tutte le immagini
LBLS = DATA{2}; %tutti i label
PATS = DATA{3}; %indici per la suddivisione dei dati
DIVS = DATA{4}; %divisori per gli indici
DIM  = DATA{5}; %numero totale di immagini presenti

%% TESTING

if size(DIVS,2) <= 1
    error("The number of folds in the dataset is not big enough for this test")
end

for fold = [1:size(DIVS,2)]
    automatedTraining;
    accuracy
end