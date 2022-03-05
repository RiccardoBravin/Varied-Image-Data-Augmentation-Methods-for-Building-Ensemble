function [IMGset,y]=PCA_DataAUG(IMGset,y,append,NumberEigen)

%we have used the https://lvdmaaten.github.io/drtoolbox/ for PCA

for banda=1:3
    clear I
    I(:,:)=im2double(IMGset(:,:,banda,1)); % convert image to gray scale and then to double precision
    [r,c] = size(I);
    AllImage=single(zeros(size(IMGset,4),r*c));
    for img=1:size(IMGset,4)
        clear I
        I(:,:)=im2double(IMGset(:,:,banda,img)); % convert image to gray scale and then to double precision
        [r,c] = size(I); % get number of rows and columns in image
        AllImage(img,:) = single(I(:)); % convert image to vector and store as column in matrix I
    end
     [mappedX{banda}, mapping{banda}] = compute_mapping(AllImage, 'PCA', NumberEigen);
     %mappedX are projected image
end
QuanteIMG=size(IMGset,4);

for img=1:QuanteIMG
    for banda=1:3
        totNewImage=0;
        %reset some random  coefficients
        K=mappedX{banda}(img,:);
        K(randi([0 1], size(K,1),size(K,2))==0)=0;
        % reconstruct test image
        I_recon = reconstruct_data(K, mapping{banda});
        %reshape reconstructed test image
        I_recon = reshape(I_recon, r,c);
        IMGset(:,:,banda,append)=I_recon;
        y(append)=y(img);
        append=append+1;
        totNewImage=totNewImage+1;
        
        %random noise
        K=mappedX{banda}(img,:);
        noise=std(K(:))/2;
        K=K+(rand(size(K))-0.5).*noise;
        % reconstruct test image
        I_recon = reconstruct_data(K, mapping{banda});
        %reshape reconstructed test image
        I_recon = reshape(I_recon, r,c);
        IMGset(:,:,banda,append)=I_recon;
        y(append)=y(img);
        append=append+1;
        totNewImage=totNewImage+1;
        
        %random coefficients from other 5 images of the same class
        label=y(img);
        SameLabel=find(y(1:QuanteIMG)==label);
        OtherIMG=randperm(length(SameLabel));
        OtherIMG=OtherIMG(1:5);
        K=mappedX{banda}(img,:);
        for other=1:5
          try  Knew=mappedX{banda}(OtherIMG(other),:);
          catch
              keyboard
          end
            RandomCoef=rand(size(K));
            RandomCoef(RandomCoef<0.95)=0;
            RandomCoef(RandomCoef>=0.95)=1;
            K(RandomCoef==1)=Knew(RandomCoef==1);
        end
        % reconstruct test image
        I_recon = reconstruct_data(K, mapping{banda});
        %reshape reconstructed test image
        I_recon = reshape(I_recon, r,c);
        IMGset(:,:,banda,append)=I_recon;
        y(append)=y(img);
        append=append+1;
        totNewImage=totNewImage+1;
        
        if banda<3
            append=append-totNewImage;
        end
    end
end
