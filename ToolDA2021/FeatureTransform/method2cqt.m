function[image] = method2cqt(im)

%apply standard deviation for every level
sigma2 = std(double(im));
sigma1 = std(sigma2);
sigma = std(sigma1)/2;

for channel=1:3
    %apply CQT
    im = double(im);
    [CQT, f, g, fshifts] = cqt(im(:,:,channel));
    [y,x,z] = size(CQT);
    for dimensione=1:z
        for riga = 1:y
            for colonna = 1:x
                % for evey dimension leave unmodified value in
                % position (1,1)
                if riga==1 && colonna==1
                    %nothing
                else
                %calculate random number between (-0.5,0.5)
                random_z = rand();
                while random_z > 1/2
                    random_z = rand();
                end
                prob = rand();
                if prob > 1/2
                    random_z = random_z * 1;
                else
                    random_z = random_z * -1;
                end
                %modify CQT
                CQT(riga, colonna, dimensione)= CQT(riga, colonna, dimensione) + sigma*random_z;
                end
            end
        end
    end
    %inverse CQT
    image(:,:,channel)= icqt(CQT, g, fshifts);
end
    image = uint8(image);
end