function [out] = elasticDeformation(IM, type, alpha)
%ElasticDeformation Deformazione elastica dell'immagine' in input
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
    fdx = conv2(dx(:,:,1),H,'same');
    fdy = conv2(dy(:,:,1),H,'same');
    
    % normalizzo
    n=sum((fdx(:).^2+fdy(:).^2));
    fdx=alpha*fdx./n;
    fdy=alpha*fdy./n;
    
    %smoothing di fdx e fdy
    fdx = imgaussfilt(fdx,3);
    fdy = imgaussfilt(fdy,3);

    %creo una griglia con gli indici della matrice
    [y, x]=ndgrid(1:size(IM,1),1:size(IM,2));

    %% Interpolazione
    R = interp2(double(IM(:,:,1)),x-fdx(:,:,1),y-fdy(:,:,1));
    R(isnan(R))=0;
    G = interp2(double(IM(:,:,2)),x-fdx(:,:,1),y-fdy(:,:,1));
    G(isnan(G))=0;
    B = interp2(double(IM(:,:,3)),x-fdx(:,:,1),y-fdy(:,:,1));
    B(isnan(B))=0;


    out = uint8(cat(3, R, G, B));
end

