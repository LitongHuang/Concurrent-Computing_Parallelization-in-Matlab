clear all;
close all;
clc;
%===Sequential Computing vs Parallel Computing (in Process based env)Ex1.1===%

% Prime number generation with storing data in 64bit 
primeNums = primes(uint64(2^17));
% Composite number generation
compositeNums = primeNums.*primeNums(randperm(numel(primeNums)));
% numel( A ) returns the number of elements
factors = zeros(numel(primeNums),2);


% n = numel( A ) returns the number of elements, n , in fi array A
% p = randperm(n) returns a row vector containing a random permutation of the integers from 1 to n without repeating elements.



%====Sequential Computing (no parallel computing)===%
delete(gcp('nocreate'));
tic; 
for i = 1:numel(compositeNums)
    factors(i,:)=factor(compositeNums(i));
end
toc

%============Parallel computing (using 4 cores) ============%
% using parfor for multicore in thread-based environment
delete(gcp('nocreate'));
parpool('local',4);

tic;
parfor i = 1:numel(compositeNums)
    factors(i,:) = factor(compositeNums(i));
end
toc 
