for i = 1:10
    accuracy{i} = load(strcat("paintings_fold", num2str(i), "_accuracy.mat")).accuracy;
end

for i = 1:10
    sum = 0;
    for j = 1:10
       sum = sum + accuracy{j}{2,i}; 
    end
    mean = sum/10;
    disp( strcat(accuracy{1}{1,i}, " = ", num2str(mean*100),"%"));
end
