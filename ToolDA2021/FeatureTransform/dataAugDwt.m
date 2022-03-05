%method with DWT that return a new training set and a new training label
%starting from old training set, old training label and the dimension of
%training set

function[trainingImages, y] = dataAugDwt(images, x, DIM1)
for t=1:DIM1
        %apply three different methods
        images(:,:,:,t+DIM1) = method1dwt(images(:,:,:,t));
        images(:,:,:,t+(2*DIM1)) = method2dwt(images(:,:,:,t));
        %search images that have the same label of the current image
        i=1;
        sameLabel = [];
        for h=1:DIM1
            if (x(t)==x(h) && t~=h)
                sameLabel(i)= h;
                i = i + 1;
            end
        end
        i = i - 1;
        for p=1:5
            samples(:,:,:,p) = images(:,:,:,sameLabel(randi(i)));
        end
        images(:,:,:,t+(3*DIM1)) = method3dwt(images(:,:,:,t),samples);
        %update training label
        x(t+DIM1) = x(t);
        x(t+(2*DIM1)) = x(t);
        x(t+(3*DIM1)) = x(t);
end
trainingImages = images;
y = x;
end