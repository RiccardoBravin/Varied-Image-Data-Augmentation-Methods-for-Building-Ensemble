
clear
for i = 1:10
    accuracy{i} = load(strcat("paintings_fold", num2str(i), "_accuracy.mat")).accuracy;
end

%accuracy
for i = 1:10
    sum = 0;
    for j = 1:size(accuracy,2)
       sum = sum + accuracy{j}{2,i}; 
    end
    mean = sum/10;
    %disp(num2str(mean*100));
    disp( strcat(accuracy{1}{1,i}, " = ", num2str(mean*100),"%"));
end

%accuracy for class
for i = 1:10
    score = 0;
    for j = 1:size(accuracy,2)
       score = score + accuracy{j}{3,i}; 
    end
    mean = score./10;
    disp(num2str(mean));
    %disp( strcat(accuracy{1}{1,i}, " = ", num2str(mean*100),"%"));
end

% 
% for i = 1:16
%     mat = 0;
%     for j = 1:size(accuracy,2)
%        mat = mat + accuracy{j}{4,i}; 
%     end
%     confusionchart(mat);
%     pause(1);
% end