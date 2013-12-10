clear;clc;
img0 = 'campanille.jpg';
img1 = 'mandrill.png';
image = img0;
%%
get_image_mat(image,1);

%% 
% Image compression and reconstruction using SVD.
img = get_image_mat(image, 0);
[U,S,V] = svd(img);

sigma_max = max(diag(S));
sigma_min = min(diag(S));
condition = sigma_max/sigma_min; %same as cond(img)

plot(diag(S));
axis([-50 1000 -100 800]);

N =200;
E_FRO = zeros(N,1);%min(size(S)),1);
E_L2  = zeros(N,1);%(size(S)),1);
%% With each step a new singular value is added
display(sprintf('Max i %d', size(S)));
R = zeros(size(img));

for i = 1:N
    %R = reconstruct(i,0,U,S,V);
    R = R + U(:,i)*S(i,i)*V(:,i)';
    i
    % Calculate the error
    err_fro = norm(R - img,'fro');
    err_l2  = norm(R-img,2);
    E_FRO(i) = err_fro;
    E_L2(i) = err_l2;
	imshow(R);
	inp = input('Press Q to quit or any other key for more singular terms: ','s');
	display(sprintf('S(i,i) = %f',S(i,i)));
	if (strcmpi(inp, 'Q'))
		break;
	end
end
close all;
p1 = plot(E_FRO, '--');
hold on;
p2 = plot(E_L2, ':');
legend([p1 p2], 'Frobenius Norm Error', 'L2 Norm Error');

display('Image recontruction done!');
%% Here we see the same thing happen in fast motion
R = zeros(size(img));

for i = 1:min(size(img))
    %R = reconstruct(i,0,U,S,V);
    R = R + U(:,i)*S(i,i)*V(:,i)';
    i
    imshow(R);
    pause(0.1);
	display(sprintf('S(i,i) = %f',S(i,i)));
end
%% Now we can see every singular value after the Lth appear iteratively. Notice the details
L = 20
R = zeros(size(img));
for i = L:length(diag(S))
    R = R + U(:,i)*S(i,i)*V(:,i)';
    i
    imshow(R);
    pause(0.1);
	display(sprintf('S(i,i) = %f',S(i,i)));
end
%% Sort of PCA
R = zeros(size(img));
for i = 1:N
    R = R + U(:,i)*S(i,i)*V(:,i)';
    component = U(:,i)*S(i,i)*V(:,i)';
    display(strcat(num2str(i),' th principal component'))
    imshow(component);
    inp = input('Press enter for the next principal component: ','s');
	display(sprintf('S(i,i) = %f',S(i,i)));
end
%% PCA
principal_component = 100;
PC = U(:,principal_component);
compressed_mat = U(:,1:principal_component);
Y = PC'*img;
Z = compressed_mat'*img;
imshow(Z);