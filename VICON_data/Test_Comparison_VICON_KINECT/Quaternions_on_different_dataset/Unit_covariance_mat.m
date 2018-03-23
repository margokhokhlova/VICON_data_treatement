% unit test covariance mat

%% data from different random distributions with added noise
N     = 15;
M     = 1000;

rho_z = 0.9;
var_z = 15.7;

K_zz  = var_z .* toeplitz(rho_z.^[0:N-1]); % Covariance matrix of the noise

x     = randn(N, M);
z     = mvnrnd(zeros(1, N), K_zz, M)';	
y     = x + z;

u = copularnd('Gaussian',-0.8,1000);
u=u';
Xa=1/(M-1)*u*(1/M* eye(M)-ones(M,M))*transpose(u);
imagesc(Xa)


