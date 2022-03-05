function[image] = method2dwt(im)

%apply standard deviation for every level
sigma2 = std(double(im));
sigma1 = std(sigma2);
sigma = std(sigma1)/2;

for channel=1:3
    %apply DWT
    [cA, cH, cV, cD] = dwt2(im(:,:,channel), 'db1');
    [x, y] = size(cA);
    for i = 1:x
        for j = 1:y
            %leave unmodified first element of the arrays
            if i==1 && j==1
                %nothing
            else
                %calculate random number between (-0.5,0.5)
                random_z = rand();
                while random_z > 1/2
                    random_z = rand();
                end
                prob = rand();
                if prob > 1/2
                    random_z = random_z * 1;
                else
                    random_z = random_z * -1;
                end
                %modify every element of the arrays
                cA(i,j)= cA(i,j) + sigma*random_z;
                cH(i,j)= cH(i,j) + sigma*random_z;
                cV(i,j)= cV(i,j) + sigma*random_z;
                cD(i,j)= cD(i,j) + sigma*random_z;
            end
        end
    end
    %inverse DWT
    image(:,:,channel) = idwt2(cA, cH, cV, cD, 'db1');
end
%resize because DWT returns an image with the right dimension
siz=size(im);
image =imresize(image,[siz(1) siz(2)]);
image = uint8(image);
end