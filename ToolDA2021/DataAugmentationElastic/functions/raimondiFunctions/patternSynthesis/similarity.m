% define a cos similiarity s of 2 vector vector1 and vector2
function [s] = similarity(vector1, vector2)
s = (vector1*vector2') / (norm(vector1) * norm(vector2));
    