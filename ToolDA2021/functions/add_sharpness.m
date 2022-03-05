%Funzione che aumenta la nitidezza dell'immagine "img" di un valore pari a
%"val", di norma compreso nel bound [0 2]. 
%(default val=0.8)

function [img_sharpness]=add_sharpness(img, val) 
    img_sharpness = img;
    img_sharpness = imsharpen(img_sharpness,'Radius',1,'Amount',val,'Threshold',0); 
    
end