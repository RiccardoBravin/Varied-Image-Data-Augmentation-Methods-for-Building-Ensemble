function res_img = color_variation(img, shift_red, shift_green, shift_blue)
%COLOR_VARIATION Modifica i colori dell'immagine aggiungendo le quantità
%specificate ad ogni canale dell'immagine

    arguments
        img (:,:,:) uint8
        shift_red double
        shift_green double
        shift_blue double
    end

    %add the correct values
    res_img(:,:,1) = img(:,:,1) + shift_red;
    res_img(:,:,2) = img(:,:,2) + shift_green;
    res_img(:,:,3) = img(:,:,3) + shift_blue;
    
    
end

