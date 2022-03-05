function[ti,y]=DataAugWARP(ti,y)

x=size(ti,4);

for i=1:x
    IM1=ti(:,:,:,i);
    k=size(ti,4);
    t=1;
    
    %xGrid is the number of distance between consecutive perturbed pixels in
    %the x axis
    %yGrid is the number of distance between consecutive perturbed pixels in
    %the y axis
    %xNoise is the size of the random perturbation in th x axis
    %yNoise is the size of the random perturbation in th y axis
    %I actually don't know exactly what maxChange stands for.
    %it seems we get a more natural image if we use small grids.
    
    xGrid = 8;
    yGrid = 10;
    xNoise = 4;
    yNoise = 5;
    maxChange = 20;
    ti(:,:,:,k+t)= changeImage2(IM1, xGrid, yGrid, maxChange, 0.4);y(k+t)=y(i);t=t+1;
    ti(:,:,:,k+t)= changeImage2(IM1, xGrid, yGrid, maxChange, 0.4);y(k+t)=y(i);t=t+1;
    
    xGrid = 10;
    yGrid = 5;
    xNoise = 8;
    yNoise = 6;
    maxChange = 20;
    ti(:,:,:,k+t)= changeImage2(IM1, xGrid, yGrid, maxChange, 0.4);y(k+t)=y(i);t=t+1;
    ti(:,:,:,k+t)= changeImage2(IM1, xGrid, yGrid, maxChange, 0.4);y(k+t)=y(i);t=t+1;
    
    xGrid = 24;
    yGrid = 18;
    xNoise = 16;
    yNoise = 16;
    maxChange = 40;
    ti(:,:,:,k+t)= changeImage2(IM1, xGrid, yGrid, maxChange, 0.4);y(k+t)=y(i);t=t+1;
    ti(:,:,:,k+t)= changeImage2(IM1, xGrid, yGrid, maxChange, 0.4);y(k+t)=y(i);t=t+1;
    
end
