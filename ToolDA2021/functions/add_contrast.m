%Funzione che modifica l'intensità dell'immagine, mappando i valori di 
%intensità dell'immagine contenuti in "range_in" in input modificandoli
%nell'immagine di output in valori contenuti in "range_out".
%Essenzialmente aumenta il contrasto dell'immagine.
%(defult range=[0 1], se si lascia vuoto viene considerato di default)

function [img_contrast]=add_contrast(img, range_in, range_out)
    img_contrast = img;
    img_contrast = imadjust(img_contrast,range_in, range_out); 
    
end