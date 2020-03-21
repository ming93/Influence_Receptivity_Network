%% Generate one cascade

f=@(lambda)(-1/lambda*log(1-rand)); % generate exponential random variable

health=[1:nc];
infect=[];
t=ones(1,nc)*inf;


now=initial;
t(initial)=0;

T=1; 

while ~isempty(health)

now=health( find(t(health) == min(t(health))) );

if t(now)>=T
    break
end

infect=[infect,now];
health=setdiff(health,infect);

to=find(A0(now,:) ~= 0);
if sum(ismember(to,infect)) == length(to) && max(t(isfinite(t)))==t(now)
    break
elseif sum(ismember(to,infect)) == length(to) && max(t(isfinite(t)))~=t(now)
    continue
else
    tt=arrayfun(f,A0(now,to))+t(now);
    t(to)=min(t(to) , tt);
end
end

% 'to' is the nodes that current node can infect. If 'to' is empty then
% continue, if it is also the last one then the infection ends.

t(t>T)=inf; % censoring
