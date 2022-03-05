%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A demonstration of the included Stain Normalisation methods.
%
%
% Adnan Khan and Nicholas Trahearn
% Department of Computer Science,
% University of Warwick, UK.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

addpath(genpath('D:\c\Lavoro\TOOL\stainN\'))
verbose=0;

%% Stain Normalisation using RGB Histogram Specification Method
trainingImages(:,:,:,DIM+append)= Norm( SourceImage, TargetImage, 'RGBHist', verbose );
AddLabel;

%% Stain Normalisation using Reinhard Method
trainingImages(:,:,:,DIM+append)= Norm( SourceImage, TargetImage, 'Reinhard', verbose ).*255;
AddLabel;

% %% Stain Normalisation using Macenko's Method
% trainingImages(:,:,:,DIM+append) = Norm(SourceImage, TargetImage, 'Macenko', 255, 0.15, 1, verbose);
% AddLabel;



