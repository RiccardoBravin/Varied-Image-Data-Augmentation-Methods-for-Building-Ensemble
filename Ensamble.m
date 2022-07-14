clear

datasets = [2 8 30 37 38 65 69 0 63 66 71 48 50 62];
%datasets = [0 0 0  37 38 65 69 0 63 66 71 48 50 62];
%datasets = [2 8 30];
%datasets = [69];

metodo = 13;
datas_ind = 1;

%agumentation scelti per ens
%PROF
%ens_choice  = [11:16,21,22,30:34];% EnsDA_Mix 
%ens_choice  = [21:31]; %EnsDA_A COLOR
%ens_choice  = [21:25,29:31]; %EnsDA_A BW

% ens_choice = [12:16,21:31]; %miei top più letteratura per color OLD
% ens_choice = [12:16,21:25,29:31]; %miei top più letteratura per bw OLD

%MIEI

%5
ens_choice = [15,16,26,28,29]; %Buono da 5

%11
%ens_choice = [12,15,16,22,24,25:27,29:31]; %buono da 11 COLOR
%ens_choice = [12,15,16,22,24,25,29:31]; %buono da 11 BW

%14
%ens_choice = [12:16,21,22,25:31];%top performance AOC RESNET Buono! COLOR
%ens_choice = [12:16,21,22,29:31];%top performance AOC RESNET Buono! BW
%ens_choice = [12 13 15 16 22 26:34]; %top performance ACC + prof 

%test
ens_choice = [16];


for datas = datasets
    clearvars -except metodo dataset ens_choice datas datasets datas_ind ens_acc AUCDatas EOCDatas
    true_lbl = [];

    try
        directory = strcat("Complete\Augmentation_", num2str(datas), "_", num2str(metodo), ".mat");

        try
            DATA = load(strcat("Datas\DatasColor_",num2str(datas),"_NOIMG.mat")).DATA;
        catch
            DATA = load(strcat("Datas\Datas_",num2str(datas),"_NOIMG.mat")).DATA;
        end

        LBLS = DATA{2}; %tutti i label
        PATS = DATA{3}; %indici per la suddivisione dei dati
        DIVS = DATA{4}; %divisori per gli indici
        DIM  = DATA{5}; %numero totale di immagini presenti

        ens_acc(datas_ind) = 0;
        load(directory);

        ens_score = cell(size(accuracy,1)-1,1);
        ens_score(:) = {0};

        for i = ens_choice
            for j = 2:size(accuracy,1)
                ens_score(j-1) = {cell2mat(ens_score(j-1)) + cell2mat(accuracy(j,i))};
            end
        end

        for i = 1:size(ens_score,1)
            try
                lbls = LBLS(PATS(i,DIVS(i)+1:DIM))'; %lables for the test images
            catch
                lbls = LBLS(PATS(i,DIVS(1)+1:DIM))'; %lables for the test images
            end

            [~,I] = max(ens_score{i},[],2);
            sing_acc(i) = sum(I == lbls)./size(lbls,1);

            %[~,~,~,ROC(i)] = average(rocmetrics(lbls,rescale(ens_score{i}),[1:max(lbls)]),"macro");
            true_lbl{i} = lbls;

        end
        
        %caalcolo di accuracy
        ens_acc(datas_ind) = mean(sing_acc); %sommare l'accuracy del presente fold

        %calcolo di EOC
        ens_score = cell2mat(ens_score);
        true_lbl = cell2mat(true_lbl');
        aux = ens_score(:,unique(true_lbl));
        
%         rocObj = rocmetrics(true_lbl,aux,unique(true_lbl));
%         [~,~,~,AUCDatas(datas_ind)] = average(rocObj,"macro");
        %disp(AUCDatas(datas_ind));

        for classe=[unique(true_lbl)']
            rocObj = rocmetrics(true_lbl, ens_score(:,classe),classe);
            AUCclasse(classe) = rocObj.AUC;
        end
        AUCclasse = AUCclasse(AUCclasse ~= 0);
        EOCDatas(datas_ind) = 100*(1-mean(AUCclasse));
        %disp(EOCDatas(datas_ind))

        datas_ind = datas_ind + 1;

    catch ERROR
        %keyboard;
        fprintf("error in dataset %d\n", datas);
        datas_ind = datas_ind + 1;
    end


end

ens_acc = ens_acc.*100;
%AUCDatas = (1-AUCDatas).*100;

disp(ens_acc);
%disp(AUCDatas);
disp(EOCDatas);


%sigrank(percA, percB) %per il p-value