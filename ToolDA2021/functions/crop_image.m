%Funzione che ritaglia l'immagine di partenza per ottenerne una di
%dimensioni "width"x"height" coi vertici traslati di "shiftwidth" in
%orizzontale e "shiftheight" in verticale

%PROBABILMENTE NON PUO' ESSERE UTILIZZATO PER VIA DELLE DIMENSIONI FISSE DI
%ALEXNET!!!

function [img_crop] = crop_image(img, width, height, shiftwidth, shiftheight)
    img_size = size(img);
    heightbot = fix( (img_size(1)-height)/2 + shiftheight );
    heighttop = heightbot+height;
    widthleft = fix( (img_size(2)-width)/2 + shiftwidth );
    widthright = widthleft+width;
    img_crop = img(heightbot:heighttop, widthleft:widthright,:);
end