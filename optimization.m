%% optimization for model A = B1 * M * B2'
%  proximal gradient descent on B1 and B2

% initialization
B1 = ones(nc,K)/10; B2 = ones(nc,K)/10; 
diff = 1; iter = 0;
lambda_B = 0.03;
eta = 0.05; 

obj = 1000;
while diff>1e-3
    
    obj_old = obj;
    iter = iter + 1;
    if iter > 600
        break
    end
    
    tic;
    B1 = max( 0, B1 + eta * grad_B1(B1, B2, M0, tall, T) - lambda_B * eta ); 
    B2 = max( 0, B2 + eta * grad_B2(B1, B2, M0, tall, T) - lambda_B * eta ); 
    t2 = toc;
    
    adjust_0 = sqrt(sum(B1,1) .* sum(B2,1));
    B1 = B1 .* (ones(nc,1) * (adjust_0 ./ sum(B1,1)));
    B2 = B2 .* (ones(nc,1) * (adjust_0 ./ sum(B2,1)));
    sparsity_B1 = sum(sum(B1 < 0.002))/nc/K; sparsity_B2 = sum(sum(B2 < 0.002))/nc/K;
    
    if mod(iter,10) == 0 
        obj = -likeli_community(B1,B2,M0,tall,T)/Nsample + lambda_B * sum(sum(B1+B2));
        diff = abs(obj - obj_old);
    end    
    
    if mod(iter,50) == 0 
        fprintf('iter=%d',iter); fprintf('  distance=%8.6f ',diff);  fprintf('  obj=%8.6f ',obj);
        fprintf(' elapesd time=%5.3f ',t2);
        fprintf(' sparsity_B1=%6.4f ',sparsity_B1); fprintf(' sparsity_B2=%6.4f \n',sparsity_B2);
    end
    
end


% estimation error
err_B1 = norm(B1 - B1_0) / norm(B1_0);
err_B2 = norm(B2 - B2_0) / norm(B2_0);


