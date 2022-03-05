function [IMGset,y]=PCA_reconstruct(IMGset,eigFaces,NumberEigen,y,append,I_mean,I_shifted);

QuanteIMG=size(IMGset,4);
for img=1:QuanteIMG
    for banda=1:3
        clear I_test
        I_test(:,:)=im2double(IMGset(:,:,banda,img)); % convert image to gray scale and then to double precision
        [r,c]=size(I_test);
        I_test = I_test(:); % convert image to vector
        I_test = I_test-I_mean; % subtract mean images
        %calculate weights of  image
        for jj = 1:NumberEigen
            I_test_weights{banda}{img}(jj,1) = dot(I_test,eigFaces{banda}(:,jj));
        end
    end
end


 [mappedX, mapping] = compute_mapping(AllImage, 'PCA', 15);
P=out_of_sample(AllImage, mapping);
P=reconstruct_data(P, mapping);

for img=1:QuanteIMG
    for banda=1:3
        totNewImage=0;
        %reset some random  coefficients
        K=eigFaces{banda}(:,1:NumberEigen);
        K(randi([0 1], size(K,1),size(K,2))==0)=0;
        % reconstruct test image
        I_recon = I_mean + K*I_test_weights{banda}{img};
        %reshape reconstructed test image
        I_recon = reshape(I_recon, r,c);
        IMGset(:,:,banda,append)=I_recon;
        y(append)=y(img);
        append=append+1;
        totNewImage=totNewImage+1;
        
        %random noise
        K=eigFaces{banda}(:,1:NumberEigen);
        noise=std(K(:))/2;
        K=K+(rand(size(K))-0.5).*noise;
        % reconstruct test image
        I_recon = I_mean + K*I_test_weights{banda}{img};
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
        K=I_test_weights{banda}{img};
        for other=1:5
          try  Knew=I_test_weights{banda}{OtherIMG(other)};
          catch
              keyboard
          end
            RandomCoef=rand(size(K));
            RandomCoef(RandomCoef<0.95)=0;
            RandomCoef(RandomCoef>=0.95)=1;
            K(RandomCoef==1)=Knew(RandomCoef==1);
        end
        % reconstruct test image
        I_recon = I_mean + eigFaces{banda}(:,1:NumberEigen)*K;
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