%function to calculate correlation c between 2 vectors v1 and v2
function[c] = correlation(v1, v2)
M = corrcoef(v1,v2);
c = M(2,1);