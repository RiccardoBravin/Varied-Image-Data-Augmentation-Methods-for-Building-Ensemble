function [out] = ElasticDeformation(IM, type, alpha)
%ElasticDeformation Deformazione elastica dell'immagine in input
% basato sulla libreria Albumentations https://gist.github.com/erniejunior/601cdf56d2b424757de5
    arguments
        IM (:,:,:)
        type (1,:) char {mustBeMember(type,{'gauss','average','disk','log','motion'})}
        alpha double
    end
    
    %% Generazione spostamenti casuali
    dx = -1+2*rand(size(IM)); 
    dy = -1+2*rand(size(IM));

    %% Creazione filtro
    if strcmp(type,'gauss')
        H = fspecial('gauss',[150, 150], 900); % crea un filtro gaussiano
    elseif strcmp(type,'average')
        H = fspecial('average',[150, 150]); % crea un filtro mediano
    elseif strcmp(type,'disk')
        H = fspecial('disk',80); % crea un filtro mediano circolare
    elseif strcmp(type,'log')
        H = fspecial('log',[150, 150], 3); % crea un filtro combinando un laplaciano e un gaussiano
    elseif strcmp(type,'motion')
        H = fspecial('motion', 900, 240); % crea un filtro che simula il movimento di una telecamera
    end
    % applico il filtro agli spostamenti
    fdx = imfilter(dx,H);
    fdy = imfilter(dy,H);
    % normalizzo
    n=sum((fdx(:).^2+fdy(:).^2));
    fdx=alpha*fdx./n;
    fdy=alpha*fdy./n;
    %creo una griglia con gli indici della matrice
    [y, x]=ndgrid(1:size(IM,1),1:size(IM,2));

    %% Interpolazione
    new1 = griddata(x-fdx(:,:,1),y-fdy(:,:,1),double(IM(:,:,1)),x,y);
    new1(isnan(new1))=0;
    new2 = griddata(x-fdx(:,:,1),y-fdy(:,:,1),double(IM(:,:,2)),x,y);
    new2(isnan(new2))=0;
    new3 = griddata(x-fdx(:,:,1),y-fdy(:,:,1),double(IM(:,:,3)),x,y);
    new3(isnan(new3))=0;

    %% Conversione in rgb
    outRed = ind2rgb(im2uint8(mat2gray(new1)),gray);
    outGreen = ind2rgb(im2uint8(mat2gray(new2)),gray);
    outBlue = ind2rgb(im2uint8(mat2gray(new3)),gray);

    outRed = outRed(:,:,1);
    outGreen = outGreen(:,:,2);
    outBlue = outBlue(:,:,3);
    out = uint8(cat(3, outRed, outGreen, outBlue)*256);
end

