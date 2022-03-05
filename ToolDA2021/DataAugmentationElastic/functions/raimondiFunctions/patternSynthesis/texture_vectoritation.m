%function to transform an rgb image IM to a characteristic vector v
function[v]=vectoritation(IM)
v = extractLBPFeatures(rgb2gray(IM));
v = [v, entropy(IM)];
v = [v, var(double(IM(:)))];
%It is possible to add here unlimited vectorization methods
