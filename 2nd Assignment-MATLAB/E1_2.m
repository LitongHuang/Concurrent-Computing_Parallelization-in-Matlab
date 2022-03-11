clear all;
close all;
clc;
%=========Parallel computing (using 1,2 and 4 cores in thread-based environment, Ex1.2)===========%

tCores = [];
numCores = [1 2 4];
% Prime number generation with storing data in 64bit 
primeNums = primes(uint64(2^19));
% Composite number generation
compositeNums = primeNums.*primeNums(randperm(numel(primeNums)));
% numel( A ) returns the number of elements

factors = zeros(numel(primeNums),2);

% using parfor for multicore (1 core)

delete(gcp('nocreate'));
parpool('local',1);

tic;
parfor i = 1:numel(compositeNums)
    factors(i,:) = factor(compositeNums(i));
end

tCores(1) = toc;

%==========================================================================%

% using parfor for multicore (2 cores)
delete(gcp('nocreate'));
parpool('local',2);

tic;
parfor i = 1:numel(compositeNums)
    factors(i,:) = factor(compositeNums(i));
end

tCores(2) = toc;

%==========================================================================%

% using parfor for multicore (4 cores)

delete(gcp('nocreate'));
parpool('local',4);
fprintf('For 1 cores:  2 cores:  4 core: ')
tic;
parfor i = 1:numel(compositeNums)
    factors(i,:) = factor(compositeNums(i));
end

tCores(3) = toc

%================= Graphing Speed-Up===================%
figure;
speedup = tCores(1)./tCores;
plot(numCores,speedup,'-*');
title('Speed-up Ratios vs Number of Cores (Workers)');
xlabel('Number of Cores (Workers)');
xticks(numCores);
ylabel('Speed-up Ratios');
grid on;