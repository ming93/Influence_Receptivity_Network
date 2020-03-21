%% gradient of log likelihood, w.r.t. B1

function grad = grad_B1( B1 , B2 , M0 , tall , T )


Nsample=size(tall,1);
nc=size(B1,1);
K=size(B1,2);

grad=zeros(nc,K);
for i=1:Nsample
    t=tall(i,:);m=M0(i,:);
    A0=B1*diag(m)*B2' ;
    fA = zeros(nc,nc);
    
    infected = t ~= inf; 
    infected_id = find(t~=inf); uninfected_id = t==inf;
    
    Tsmall = ((ones(sum(infected),1) * t) < (ones(nc,1) * t(infected))')';
    Beta = A0(:,infected_id);
    Beta_Tsmall = Beta; Beta_Tsmall(~Tsmall) = 0;
    cal1 = 1./sum(Beta_Tsmall) - t(infected_id); Cal1 = ones(nc,1) * cal1; Cal1_Tsmall = Cal1; Cal1_Tsmall(~Tsmall) = 0;
    Tt = (ones(sum(infected),1) * t)';
    Tt_Tsmall = Tt; Tt_Tsmall(~Tsmall) = 0;
    
    fA(:,infected_id) = Cal1_Tsmall + Tt_Tsmall;
    tsmall=t<T; % for those uninfected p
    fA(tsmall,uninfected_id) = (t(tsmall) - T)' * ones(1,sum(uninfected_id));
    
    MB2 = diag(m)*B2';
    grad = grad + fA * MB2';

end

grad = grad/Nsample;