function imgw = changeImage2(IM, xGrid, yGrid, maxChange, coeff)
%   maxChange serve per l'interpolazione non metta valori piccoli 10 va
%   bene

     mult=floor(size(IM,1)/xGrid);   %|
     rnd=floor(rand(1)*(mult)+1);    %|  calcola dove mettere l'asse per la distorsione in maniera tale che sia un multiplo del passo della griglia
     asse=xGrid*rnd;                 %| 
%    asse=40;
%     [a,b,c]=calcParabolaOrizz([asse,xNoise],[0,0]);
%     parab1=[a,b,c];
%     [a,b,c]=calcParabolaOrizz([asse,xNoise],[size(IM,1),0]);
%     parab2=[a,b,c];

    [a,b,c]=calcParabolaOrizz([asse,asse],[0,0]);     %parabola che trasla i pixel tra zero e l'asse
    parab1=[a,b,c];
    [a,b,c]=calcParabolaOrizz([asse,asse],[size(IM,1),size(IM,1)]);    %parabola che trasla i pixel tra l'asse e la fine dell'immagine
    parab2=[a,b,c];
    %creo le griglie con i punti originali (Z) e le loro immagini (Y)
    i = 1;
    for row = xGrid: xGrid: size(IM,1)%-xGrid
        if(row<asse)
                row2 = round(coeff*min(parab(parab1,row))+(1-coeff)*(row));
            else
                %Y(i,2) = row; %+ parab(parab2,row);
                row2 = round(coeff*max(parab(parab2,row))+(1-coeff)*(row));
            end
        for col = yGrid: yGrid: size(IM,2)%-yGrid
            Y(i,1) = col;   % |funzione di destinazione dei pixel
            Y(i,2) = row2;  % |
            
            Z(i,1) = col;
            Z(i,2) = row;
            i = i+1;
        end
    end
    i = 1;
%     for row = xGrid: xGrid: size(IM,1)%-xGrid
%         for col = yGrid: yGrid: size(IM,2)%-yGrid
%             Z(i,1) = col;
%             Z(i,2) = row;
%             i = i + 1;
%         end
%     end

    %scelgo le opzioni
    interp = struct();
    interp.method = 'nearest';
    interp.radius = maxChange;
    interp.power = 1;
    
    %chiamo la function nel tool
    [imgw, imgwr, map] = tpswarp(single(IM),[size(IM,2),size(IM,1)],Z,Y,interp);
end

function [y1] = parab(p,x)
%PARAB
%   dati i valori dei termini costanti dell'equazione di una parabola
%   e la coordinata x calcola y
%   p=[a,b,c]
syms y
eqns=[(p(1)*y^2 + p(2)*y +p(3)) ==x];
tmpY=solve(eqns, y);
y1=(double(tmpY));
end

function [a1, b1, c1] = calcParabolaOrizz(vertex,point)
%CALCPARABOLA calcola i valori delle costanti della funzione di una
%parabola, parallela con asse di simmetria verticale dato il vertice ed un punto
%nella formula x= a*y^2 + b*y +c
%   vertex= [x, y]    vertice
%   point= [x, y]       punto
syms a b c
xv=vertex(1);
yv=vertex(2);
px=point(1);
py=point(2);

eqns1= -(b/(2*a)) == yv;
eqns2=-((b^2 - 4*a*c)/(4*a)) ==xv;
eqns3=a*py^2 + b*py +c ==px;
vars=[a b c];
[ tmpA, tmpB, tmpC]=solve(eqns1,eqns2,eqns3, vars);

a1=double(tmpA);
b1=double(tmpB);
c1=double(tmpC);
end
