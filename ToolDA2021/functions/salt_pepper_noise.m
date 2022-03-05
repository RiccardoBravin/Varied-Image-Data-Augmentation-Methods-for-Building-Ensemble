%Funzione che applica un rumore sale e pepe con densità "density".
%La densità di default è 0.05

function [img_noise]=salt_pepper_noise(img, density)
    img_noise = img;
    img_noise = imnoise(img,'salt & pepper',density);
    
end