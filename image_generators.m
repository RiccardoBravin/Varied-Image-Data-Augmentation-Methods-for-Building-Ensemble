clear
load("DatasColor_65.mat",'DATA');
im_dim=[224,224];

IMG = DATA{1}{1};
training_imgs(:,:,:,1) = imresize(IMG(:,:,:,:),[224,224]);
training_lbls = 1;
tr_data_sz = 1;

% ChannelRemoval;
% Classic;
% ColorReduction;
% ColorShift;
% ColorspaceChange;
% ColorVariation;
% ContentFill;
% DCT;
% Deconvolution;
% DecorrStretch;
% Deformation;
% Dehaze;
% DenoiseMF2;
% DenoiseWDC;
% Dithering;
% FFT;
% FFT_2;
% FFTCombine;
% Hampel;
% HilbertTransform;
% Histeq;
% Laplacian;
% Negative;
% Pixelate;
% PixelShuffle;
% PolarDecomposition;
% Project;
 RadonT;
% SingValDec;
% SuperPixel;
% Vignetting;

%% combine image



% for i = 1: size(training_lbls,2)
%     %%mon{i} = training_imgs(:,:,:,i);
%     imwrite(training_imgs(:,:,:,i),strcat("Imgs/" , num2str(i), "img.png"))
% end

imtile(training_imgs);
%montage(mon);