%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%Coregistration%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%


function coregistration

%% Housekeeping
clear matlabbatch 

%nrun = 1; % enter the number of runs/sessions here - important when multiple runs/sessions

datapath = '/Users/nelebehrens/Documents/data/methods_fMRI/sub-003/Analysis'; %insert path where all datafiles/images a stored
cd(datapath);%propbably those two lines are necessary later in the batchfile to lead to our directory and not here anymore

%Initialise SPM & SPM_Jobman defaults--> necessary to set up SPM can probably be put into batch script as well because it only needs to run
%once within one matlab session to execute any SPM functions and batch jobs
%spm('defaults', 'FMRI');
%spm_jobman('initcfg');

%% Coregistration - Create & fill Matlabbatch

matlabbatch{1}.spm.spatial.coreg.estimate.ref = {'/Users/nelebehrens/Documents/data/methods_fMRI/sub-003/Analysis/run_1/meanMFV6254-0006-00001-000001.nii'};%CHANGE PATH - mean functional image from realignment
matlabbatch{1}.spm.spatial.coreg.estimate.source = {'/Users/nelebehrens/Documents/data/methods_fMRI/sub-003/Analysis/structural/MFV6254-0002-00001-000001.nii'};%CHANGE PATH - Structural Image
matlabbatch{1}.spm.spatial.coreg.estimate.other = {''};
matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.cost_fun = 'nmi';
matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.sep = [4 2];
matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.fwhm = [7 7];

%% EXTRA
%jobs = repmat(jobfile, 1, nrun);
%inputs = cell(0, nrun); no idea if we need line 37-38, the script worked
%well without them and I can't  find what they are good for - maybe also
%necessary if you have multiple runs

%for crun = 1:nrun
%end - %only necessary when having multiple runs/sessions

%% Execute Job
spm_jobman('run', matlabbatch); %Run Coregistration - note: choosing 'run' executes job without opening batch editor