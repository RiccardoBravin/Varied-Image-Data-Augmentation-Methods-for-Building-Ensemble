

for pattern = interval    
    i = 1;
    while i <= iterations
        his = imhist(training_imgs(:,:,:,randi([interval(1), interval(length(interval))])));
        img = histeq(training_imgs(:,:,:,pattern),his);
        
        training_imgs(:,:,:,tr_data_sz+append) = img;
        training_lbls(tr_data_sz+append)=training_lbls(pattern);
        append = append + 1;
        i = i + 1;
        
    end
end

clearvars i pattern img his

