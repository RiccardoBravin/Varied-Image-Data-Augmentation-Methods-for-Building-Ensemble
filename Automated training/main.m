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
for fold = [1:size(DIVS,2)]
    automatedTraining;
end