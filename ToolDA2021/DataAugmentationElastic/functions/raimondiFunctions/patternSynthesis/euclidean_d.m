%function to calculate the euclidean distance d between 2 vectors v1, v2 
function [d] = euclidean_d(v1, v2)
d = norm(v1 -v2);