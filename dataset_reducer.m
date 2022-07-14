clear all
datas = 69;
DATA = load(strcat("Datas\DatasColor_",num2str(datas))).DATA;

imshow(DATA{1,1}{1,1})
DATA{1} = 0;

save(strcat("Datas\DatasColor_",num2str(datas),"_NOIMG.mat"),"DATA");
    