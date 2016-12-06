% reconstruct the image with EM algorithm from weak random signal.

%  set input paramter.
N_rot=4;  % number of possible rotation of sample
N_f=10000;    % number of total frames
N_iter=120;    % set number of iterations

load frames.mat
ar=2*pi/N_rot;
% k1=rand(200);
% k1=w(:,:,47);
% w=zeros(200,200,N_iter,'double');
% w(:,:,1)=k1;      % we start from a random model
k=zeros(200,200,'double');


for iter=47:N_iter 
   w_rot=zeros(200,200,N_rot,'double');
   for n1=1:N_rot
       for l1=1:200
          for m1=1:200
             l11=round(100.5+(l1-100.5)*cos(n1* ar)+(m1-100.5)*sin(n1* ar));
             m11=round(100.5-(l1-100.5)*sin(n1* ar)+(m1-100.5)*cos(n1* ar));
                         w1(l11,m11)=w(l1,m1,iter);
          end
       end
       w_rot(:,:,n1)= w1;
   end

% calculate the probability of frames in all possible orientation with an
% model
   P=ones(N_f,N_rot,'double');
   for l=1:N_f
       for m=1:N_rot
           for i=1:200
               for j=1:200
                   if frames(i,j,l)>0
                      P(l,m)=P(l,m)*w_rot(i,j,m);
                   end
               end
           end
        end
   end

% normalize the probability
   for i=1:N_f
       P_tot=sum(P(i,:));
       for j=1:N_rot
           if P_tot>0
             P(i,j)=P(i,j)/P_tot;
           else
             P(i,j)=0.25;
           end
       end
   end

% calculate the new model from the probability in last step, which could
% maximize the likehood function
   for n=1:N_f
       for i=1:200
           for j=1:200
               k(i,j)=P(n,1)* frames(j,201-i,n) +P(n,2)*frames(201-i,201-j,n)+P(n,3)* frames(201-j,i,n) +P(n,N_rot)*frames(i,j,n);
           end
       end
       w(:,:,iter+1)=w(:,:,iter+1)+k;
   end

 % save the model as well as possibilities at current iteration.
   save w_test2.mat w
%    b=['P_' int2str(iter) '.mat'];
%    save(b,'P')
   iter
end