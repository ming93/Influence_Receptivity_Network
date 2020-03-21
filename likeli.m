%% Likelihood function

function s = likeli( m , Tall , num , T ) 

a0=Tall(:,num)~=0;
tall0=Tall(a0,:);

s=0;

for k=1:size(tall0,1)
    u=tall0(k,:);
    if u(num) == inf % uninfected
        tsmall=find(u~=inf);
        s=s- sum( m(tsmall) .* (T-u(tsmall)) );
    else  % infected
        tsmall=find(u < u(num));
        s=s + log(sum(m(tsmall))) - sum( m(tsmall).*(u(num)*ones(1,length(tsmall))-u(tsmall)) );
    end

end