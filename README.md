# Varied Image Data Augmentation Methods for Building Ensemble

This repository contains code about the thesis research on the field of Data Augmentation for CNN ensambles 

Published paper can be found at: https://ieeexplore.ieee.org/document/10025727
Missing resources are available at https://github.com/LorisNanni

## Abstract 

Convolutional Neural Networks (CNNs) are used in many domains but the requirement of large datasets for robust training sessions and no overfitting makes them hard to apply in medical fields and similar fields. However, when large quantities of samples cannot be easily collected, various methods can still be applied to stem the problem depending on the sample type. Data augmentation, rather than other methods, has recently been under the spotlight mostly because of the simplicity and effectiveness of some of the more adopted methods. The research question addressed in this work is whether data augmentation techniques can help in developing robust and efficient machine learning systems to be used in different domains for classification purposes. To do that, we introduce new image augmentation techniques that make use of different methods like Fourier Transform (FT), Discrete Cosine Transform (DCT), Radon Transform (RT), Hilbert Transform (HT), Singular Value Decomposition (SVD), Local Laplacian Filters (LLF) and Hampel filter (HF). We define different ensemble methods by combining various classical data augmentation methods with the newer ones presented here. We performed an extensive empirical evaluation on 15 different datasets to validate our proposal. The obtained results show that the newly proposed data augmentation methods can be very effective even when used alone. The ensembles trained with different augmentations methods can outperform some of the best approaches reported in the literature as well as compete with state-of-the-art custom methods.
