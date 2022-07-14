clear

datasets = [2 8 30 37 38 65 63 66 71 48 50 62];
%datasets = [37 38 65 63 71 48 50 62];
metodo = 5;

datas_ind = 1;

%x = nchoosek([2:16,18:20,21:25,29:34],5); %Per datas 2,8,30
x = nchoosek([12:16,21:31],11);  %per gli altri datas

MEAN_ACC = zeros(1,size(x,1));
EOCDatas = zeros(size(x,1),size(datasets,2));

for datas = datasets
    
    %dataset
    try
        DATA = load(strcat("Datas\DatasColor_",num2str(datas),"_NOIMG.mat")).DATA;
    catch
        DATA = load(strcat("Datas\Datas_",num2str(datas),"_NOIMG.mat")).DATA;
    end

    %Prep dataset
    LBLS = DATA{2}; %tutti i label
    PATS = DATA{3}; %indici per la suddivisione dei dati
    DIVS = DATA{4}; %divisori per gli indici
    DIM  = DATA{5}; %numero totale di immagini presenti
    
    %augmentation
    directory = strcat("Complete\Augmentation_", num2str(datas), "_", num2str(metodo), ".mat");
    load(directory);

    

    %cycling all combinations
    for ind_x = 1:size(x,1)
        ens_choice = x(ind_x,:);

        ens_score = cell(size(accuracy,1)-1,1);
        ens_score(:) = {0};

        true_lbl = [];


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
            
            true_lbl = cat(1,true_lbl,lbls);

            [M,I] = max(ens_score{i},[],2);
            sing_acc(i) = sum(I == lbls)./size(lbls,1);

        end
    
%         aux = cell2mat(ens_score);
% 
%         for classe= unique(true_lbl)'
%             rocObj = rocmetrics(true_lbl, aux(:,classe),classe);
%             AUCclasse(classe) = rocObj.AUC;
%         end
% 
%         AUCclasse = AUCclasse(AUCclasse ~= 0);
%         EOCDatas(ind_x,datas_ind) = 100*(1-mean(AUCclasse));

        ens_acc = mean(sing_acc); %sommare l'accuracy del presente fold
        MEAN_ACC(ind_x) = MEAN_ACC(ind_x) + ens_acc * 100;
        %disp(ens_acc*100);

    end

    datas_ind = datas_ind + 1;
end

[t1,t2] = max(MEAN_ACC);
disp(x(t2,:));
x(t2,:);

[t1,t2] = min(mean(EOCDatas,2));
disp(x(t2,:));
x(t2,:);