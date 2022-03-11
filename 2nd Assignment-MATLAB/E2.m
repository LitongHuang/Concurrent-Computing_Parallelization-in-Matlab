clear all; close all; clc

%=========Parallel computing (using 1,2 and 4 cores in thread-based environment, Ex2)===========%
% Calculation: Finding maximum eigenValue of a random matrix

numCores = [1 2 4];
time = [0 0 0];

L = 1000; % Length of the matrix to be generated
c = [];


% Do the calculation using parfor for singlecore (1 core)
delete(gcp('nocreate'))
pool = parpool(1);
tic;
parfor i = 1:12
  c(i) = max(eig(rand(L)));
end
time(1) = toc;

% Do the calculation using parfor for Multicore (2 cores)
delete(gcp('nocreate'))
pool = parpool(2);
tic;
parfor i = 1:12
  c(i) = max(eig(rand(L)));
end
time(2) = toc;

% Do the calculation using parfor for Multicore (4 cores)
delete(gcp('nocreate'))
pool = parpool(4);
tic;
parfor i = 1:12
  c(i) = max(eig(rand(L)));
end
time(3) = toc

%================= Graphing Speed-Up===================%
figure;
speedup = time(1)./time;
plot(numCores,speedup,'-*');
title('Speed-up Ratios vs Number of Cores (Workers)');
xlabel('Number of Cores (Workers)');
xticks(numCores);
ylabel('Speed-up Ratios');
grid on;

