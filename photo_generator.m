
% load the image as a matrix
I1 = imread('L.jpg');   
I2= mat2gray(I1); 
Image = ones(200,200)-I2(:,:,1); 

% input paramter.
N_rot=4;  % number of possible rotation of sample
signal=40;   % number of photons per frames
N_f=10000;    % number of total frames

% creat matrices to record all the models and frames.
w_rot=zeros(200,200,N_rot);
frames=zeros(200,200,N_f,'single');

% generate all possible rotation of a given model
   K1=zeros(200,200);
   ar=2*pi/N_rot;
   for n1=1:N_rot
       for l1=1:200
          for m1=1:200
             l11=round(100.5+(l1-100.5)*cos(n1* ar)+(m1-100.5)*sin(n1* ar));
             m11=round(100.5-(l1-100.5)*sin(n1* ar)+(m1-100.5)*cos(n1* ar));
                         K1(l11,m11)=Image(l1,m1);
          end
       end
       w_rot(:,:,n1)= K1;
   end

   % simulate the experimental photoing process.
for i=1:N_f
        n1=randi(N_rot,1,1);
        n=poissrnd(signal,1,1);
        k=randi(200,n,1);
        l=randi(200,n,1);
        for j=1:n;
          frames(k(j),l(j),i)=w_rot(k(j),l(j),n1);
        end
end
save frames.mat frames