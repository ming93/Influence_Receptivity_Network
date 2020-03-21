%% Likelihood function, for community

function f = likeli_community( B1 , B2 , M0 , tall , T ) 


f=0;
for i=1:size(tall,1)
    t=tall(i,:);m=M0(i,:);
    A0=B1*diag(m)*B2'; %+ Know;
    %s=0;
    for k=1:size(tall,2)
        a=A0(:,k)';
        f=f+likeli(a,t,k,T);
        %s=s+likeli(a,t,k,T);
    end
    %ss(i)=s;
end

end