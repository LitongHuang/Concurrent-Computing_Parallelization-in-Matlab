% Parallel Computing ("Process-based vs thread based environment for 4 workers for both", Ex3)

clear all; close all; clc

% Calculation (random numbers generation)
X = rand(3000, 3000);

% Parallel Computing ("Process-based environment on local machine")
delete(gcp('nocreate'))
pool = parpool('local');
% Execution time calcutation
ticBytes(pool);
%Time for trasnfering data (in Process Based Environment)
tProcesses = timeit(@() fetchOutputs(parfeval(@sum,1,X,'all')))
tocBytes(pool)

% Parallel Computing ("Thread-based environment on local machine")
delete(gcp('nocreate'))
pool = parpool('threads');
%
ticBytes(pool);
%Time for trasnfering data (in Thread Based Environment)
tThreads = timeit(@() fetchOutputs(parfeval(@sum,1,X,'all')))
tocBytes(pool)


fprintf('Without data transfer, this example is %.2fx faster.\n', tProcesses/tThreads)
