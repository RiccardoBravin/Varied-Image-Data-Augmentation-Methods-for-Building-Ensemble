clear
datas = 69;
metodo = 13;

directory1 = strcat("Results\TunedAddingDatasetsAUGMENTATIONbravin_", num2str(datas),"_color_",num2str(metodo),"*");
directory2 = strcat("Results2\AugmentationBravinBIS_", num2str(datas), "_color_",num2str(metodo),"*");
%directory3 = strcat('Results prof\TunedAddingDatasetsAUGMENTATION_',num2str(datas),'_',num2str(metodo),'*');
directory3 = strcat('Results prof\TunedAddingDatasetsAUGMENTATION_',num2str(datas),'_color_',num2str(metodo),'*');

f_dir1 = dir(directory1);
f_dir2 = dir(directory2);
f_dir3 = dir(directory3);

f_ls1 = natsortfiles({f_dir1.name})';
f_ls2 = natsortfiles({f_dir2.name})';
f_ls3 = natsortfiles({f_dir3.name})';

for i = 1:size(f_dir1,1)
    try
        accuracy1 = load(strcat("Results\",f_ls1(i))).accuracy;
        for j = 1:16
            accuracy(1,j) = accuracy1(1,j);
            accuracy(i+1,j) = accuracy1(5,j);
        end
    catch
    end
    try
        accuracy2 = load(strcat("Results2\",f_ls2(i))).accuracy;
        for j = 17:20
            accuracy(1,j) = accuracy2(1,j-16);
            accuracy(i+1,j) = accuracy2(5,j-16);
        end
    catch
    end
end

for i = 1:size(f_dir3,1)
    score = load(strcat("Results prof\",f_ls3(i))).score;
    score = score';
    accuracy(1,i+20) = {strcat("AUG",num2str(i-1))};
    for j = 1:size(score,1)
        accuracy(j+1,i+20) = score(j);
    end

end

save(strcat("Complete\Augmentation_",num2str(datas),'_',num2str(metodo),".mat"), "accuracy");