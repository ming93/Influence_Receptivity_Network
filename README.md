
## Description
Codes for recovering the influence-receptivity structure in networks

## References
Ming Yu, Varun Gupta, and Mladen Kolar. 
“Estimation of a Low-rank Topic-Based Model for Information Cascades”, to appear in Journal of Machine Learning Research. Full paper is available on arXiv: https://arxiv.org/abs/1709.01919. 


Please see also the following two closely related works:

- Learning Influence-Receptivity Network Structure with Guarantee. AISTATS 2019. 
- An Influence-Receptivity Model for Topic based Information Cascades. ICDM 2017. 

## Run codes
The main codes are the following two:

- Data_generation.m: generate true coefficient matrix B1_0, B2_0 and generate cascades
- optimization.m: alternating proximal gradient descent

Run these two scripts to get the results. Other helper functions:

- drchrnd.m: generate sample from Dirichlet distribution; this is used for topic weight generation
- grad_B1.m: calculate gradient with respect to B1
- grad_B2.m: calculate gradient with respect to B2
- likeli.m: calculate the likelihood function value
- likeli_community.m: calculate the likelihood function value
- One_data.m: generate one data/cascade


