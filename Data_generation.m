%% These are the codes for the paper 
%  ?Estimation of a Low-rank Topic-Based Model for Information Cascades?, 
%  to appear in Journal of Machine Learning Research. 
%  Full paper is available on arXiv: https://arxiv.org/abs/1709.01919. 


% nc: number of nodes, K: number of topics, Nsample: number of cascades
% generate random B1 and B2
nc = 10; K = 4; 
Nsample = 300;
%rng(2);
B1_0=zeros(nc,K); B2_0=zeros(nc,K);
for i=1:nc
    nn_1 = randsample([1:K],randsample([1:2],1));
    nn_2 = randsample([1:K],randsample([2:3],1));
    B1_0(i,nn_1)=( rand(length(nn_1),1)+0.7 ) * (binornd(1,0.1)*1.5+1) / 3 ;
    B2_0(i,nn_2)=( rand(length(nn_2),1)+0.7 ) * (binornd(1,0.1)*1.5+1) ;
end

% let B1 and B2 have the same column sum
% need to guarantee that the column sums are not 0

adjust_0 = sqrt(sum(B1_0,1) .* sum(B2_0,1));
for i = 1:K
    if adjust_0(i) ==0
        nnn_1 = randsample([1:nc],randsample([1:2],1));
        nnn_2 = randsample([1:nc],randsample([1:2],1));
        B1_0(nnn_1,i) = ( rand(length(nnn_1),1)+0.8 ) * (binornd(1,0.2)*1.5+1) ;
        B2_0(nnn_2,i) = ( rand(length(nnn_2),1)+0.8 ) * (binornd(1,0.2)*1.5+1) ;
    end
end

adjust_0 = sqrt(sum(B1_0,1) .* sum(B2_0,1));
B1_0 = B1_0 .* (ones(nc,1) * (adjust_0 ./ sum(B1_0,1))) / 1.2;
B2_0 = B2_0 .* (ones(nc,1) * (adjust_0 ./ sum(B2_0,1))) / 1.2;


%% Generate data


M0=zeros(Nsample,K);tall=zeros(Nsample,nc); % record the data and M

for i=1:Nsample
    initial=randsample(1:nc,1); % choose initial uniformly from those infect others
    m=drchrnd(B1_0(initial,:),1);
        
    M=diag(m);M0(i,:)=m;
    A0=B1_0*M*B2_0' ;
    A0(eye(nc)~=0)=0;
    One_data;
    tall(i,:)=t;
end

