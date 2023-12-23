%%%%%%%%%%%%%%%%%%%%%%%%%%
%Normalisation_functional%
%%%%%%%%%%%%%%%%%%%%%%%%%%

function normalisation_f

%% Housekeeping
clear matlabbatch 

run = {'1' '2' '3' '4' '5' '6' '7'};
%nrun = 1; % enter the number of runs/sessions here - important when multiple runs/sessions

for  k = 1:length(run)

datapath = ['/Users/nelebehrens/Documents/data/methods_fMRI/sub-003/Analysis/run_', run{k}]; %CHANGE PATH: insert path where all epis are stores
cd(datapath);%propbably those two lines are necessary later in the batchfile to lead to our directory and not here anymore

imgfiles = dir('rMFV*.nii'); %specify filenames which should be included in the dataprocessing (here referes to all files starting with f)
path = fullfile(datapath, {imgfiles.name}); %specify which data to include by concatenating the data path to the specific file names

%Initialise SPM & SPM_Jobman defaults--> necessary to set up SPM can probably be put into batch script as well because it only needs to run
%once within one matlab session to execute any SPM functions and batch jobs
%spm('defaults', 'FMRI');
%spm_jobman('initcfg');

%% Normalisation_functional - Create & fill Matlabbatch
matlabbatch{1}.spm.spatial.normalise.write.subj.def = {'/Users/nelebehrens/Documents/data/methods_fMRI/sub-003/Analysis/structural/y_MFV6254-0002-00001-000001.nii'};%CHANGE PATH = deformation field from stuctural scan (image with an 'y')
%%
matlabbatch{1}.spm.spatial.normalise.write.subj.resample = path';%doesn't need to be converted into cell structure not sure why (note: same for smoothing)
%%
matlabbatch{1}.spm.spatial.normalise.write.woptions.bb = [-78 -112 -70
                                                          78 76 85];
matlabbatch{1}.spm.spatial.normalise.write.woptions.vox = [3 3 3];
matlabbatch{1}.spm.spatial.normalise.write.woptions.interp = 4;
matlabbatch{1}.spm.spatial.normalise.write.woptions.prefix = 'w';

%% EXTRA
%jobs = repmat(jobfile, 1, nrun);
%inputs = cell(0, nrun); no idea if we need line 37-38, the script worked
%well without them and I can't  find what they are good for - maybe also
%necessary if you have multiple runs

%for crun = 1:nrun
%end - %only necessary when having multiple runs/sessions

%% Execute Job
spm_jobman('run', matlabbatch); %Run normalisation functional - note: choosing 'run' executes job without opening batch editor

end
