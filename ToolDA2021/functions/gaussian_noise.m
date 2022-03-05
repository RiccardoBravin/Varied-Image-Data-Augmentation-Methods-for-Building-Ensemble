%Funzione che applica un rumore gaussiano con media "mean"

function [img_noise]=gaussian_noise(img, mean)
    img_noise = img;
    img_noise = imnoise(img,'gaussian',mean);
    
end