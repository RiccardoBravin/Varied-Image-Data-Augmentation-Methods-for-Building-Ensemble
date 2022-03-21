
clear all
close all force
warning off

string = 'C:\Users\Riccardo Bravin\Desktop\NN_image_augmentation\Data maker\Bark-101-reduction\';

pos = 1;

for i = 0 : 10
    directory = strcat(string, num2str(i), "\*.jpg");
    files = dir(directory);
    dim = length(files);
    for j = 1 : dim
        imgs{pos} = imread(files(j).name);
        labels(pos) = i+1;
        pos = pos + 1;
    end
    
end

%%
pos=1;
for i = 1 : 101
    cnt = sum(labels == i);
    test_n = randi([floor(cnt/4) floor(cnt/3)]);
    if test_n == 0
        test_n = 1;
    end
    for j = 1:length(labels)
        if(labels(j) == i && test_n > 0)
            test_labels{pos} = j;
            test_n = test_n - 1;
            pos = pos + 1;
        end
    end
    
end
%%
pos = 1;
found = false;

for lab = 1 : length(labels)
    for x = cell2mat(test_labels)
        if x == lab
            found = true;
        end
    end
    %extra perchè c'è solo una foto
    if labels(lab) == 34
       found = false; 
    end
    if ~found
        training_labels{pos} = lab;
        pos = pos + 1;
    end
    found = false;
end
%% 

DATA{1} = imgs;
DATA{2} = labels;
DATA{3} = cell2mat([training_labels test_labels]);
DATA{4} = [length(training_labels)];
DATA{5} = length(imgs);

%%
%DATA1{3}{1,:} = DATA2{3};

