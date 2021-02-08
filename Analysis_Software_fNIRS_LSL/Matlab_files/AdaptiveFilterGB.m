function [result] = AdaptiveFilterGB(d, u, N); 
 
M=length(d); 
 
%-----Filter Parameters-----; 
delta = 1;  
lamda = 0.99;  
 
%-----Initialize----- 
y=zeros(M,1); 
w = zeros(N,1); 
u1 = zeros(N,1); 
P = eye(N)/delta; 
 
 
i = 1; 
 
while i<M 
    if i<N 
        u1(N:-1:N-i+1)=u(i:-1:1); 
    else  
        u1(N:-1:1) = u(i:-1:i-N+1); 
    end 
    y(i) = w'*u1; 
    %-----RLS algorithm----- 
    %k = (P*u1)/(lamda + u1'*P*u1);        
    %k = P*u1; 
    %-----LMS algorithm----- 
    k = 0.05*u1; 
    E = d(i) - w'*u1; 
    w = w + k*E; 
     
    %P = (P/lamda) - (k*u1'*P/lamda); 
    %P = (P/lamda) - (k*u1'*P/(lamda*(lamda + u1'*P*u1))); 
    i = i + 1; 
end 
 
result=y;