
for pattern = interval
    
    img(:,:,:)=training_imgs(:,:,:,pattern);
    
       
    [thr,sorh,keepapp] = ddencmp('den','wv',img(:,:,1));
    R = wdencmp('gbl',img(:,:,1),'sym4',2,thr,sorh,keepapp);
    [thr,sorh,keepapp] = ddencmp('den','wv',img(:,:,2));
    G = wdencmp('gbl',img(:,:,2),'sym4',2,thr,sorh,keepapp);
    [thr,sorh,keepapp] = ddencmp('den','wv',img(:,:,3));
    B = wdencmp('gbl',img(:,:,3),'sym4',2,thr,sorh,keepapp);


    img = uint8(cat(3,R,G,B));
    %montage({training_imgs(:,:,:,pattern), img});
    
    training_imgs(:,:,:,tr_data_sz+append) = img;
    training_lbls(tr_data_sz+append)=training_lbls(pattern);
    append = append + 1;
    
end

clearvars i pattern img R G B X ind

