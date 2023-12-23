%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%Realingment%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%

function realignment

%% Housekeeping
clear matlabbatch 

run = {'1' '2' '3' '4' '5' '6'};
%nrun = 1; % enter the number of runs/sessions here - important when multiple runs/sessions

for  k = 1:length(run)
    datapath = ['/Users/nelebehrens/Documents/data/methods_fMRI/sub-003/Analysis/run_', run{k}]; %CHANGE PATH - run-folder
    cd(datapath);
    imgfiles = dir('MFV*.nii'); 
    path{k} = fullfile(datapath, {imgfiles.name})'; %specify which data to include by concatenating the data path to the specific file names
end


%Initialise SPM & SPM_Jobman defaults--> necessary to set up SPM can probably be put into batch script as well because it only needs to run
%once within one matlab session to execute any SPM functions and batch jobs
%spm('defaults', 'FMRI');
%spm_jobman('initcfg');

%% Realingment - Create & fill Matlabbatch

matlabbatch{1}.spm.spatial.realign.estwrite.data = path; %choose images - saved as one varible before (path); datafiles are transformed into cell array & from row to column                                                                                                           
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.quality = 0.9;
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.sep = 4;
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.fwhm = 5;
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.rtm = 1;
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.interp = 2;
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.wrap = [0 0 0];
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.weight = '';
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.which = [2 1]; %creates & safes individual resliced images & creates a mean of the resliced images
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.interp = 4;
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.wrap = [0 0 0];
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.mask = 1;
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.prefix = 'r';

%% EXTRA
%jobs = repmat(jobfile, 1, nrun);
%inputs = cell(0, nrun); no idea if we need line 37-38, the script worked
%well without them and I can't  find what they are good for - maybe also
%necessary if you have multiple runs

%for crun = 1:nrun
%end - %only necessary when having multiple runs/sessions

%% Execute Job
spm_jobman('run', matlabbatch); %Run realingment - note: choosing 'run' executes job without opening batch editor