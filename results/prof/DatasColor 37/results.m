for i = 1:5
    accuracy{i} = load(strcat("DatasColor_37_", num2str(i), "_accuracy.mat")).accuracy;
end

for i = 1:16
    sum = 0;
    for j = 1:5
       sum = sum + accuracy{j}{2,i}; 
    end
    mean = sum/5;
    disp( strcat(accuracy{1}{1,i}, " = ", num2str(mean*100),"%"));
end


for i = 1:16
    mat = 0;
    for j = 1:5
       mat = mat + accuracy{j}{4,i}; 
    end
    confusionchart(mat);
    pause(1);
end