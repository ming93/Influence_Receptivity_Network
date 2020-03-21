function r = drchrnd(a,n)
% generate a sample from a dirichlet distribution

p = length(a);
r = gamrnd(repmat(a,n,1),1,n,p);
%r = r ./ repmat(sum(r,2),1,p);
r = r / sum(r);