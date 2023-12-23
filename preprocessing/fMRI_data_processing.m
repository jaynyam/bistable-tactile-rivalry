%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%fMRI%Data%Processing%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

datapath = '/Users/nelebehrens/Documents/data/methods_fMRI/sub-003/Analysis'; %insert path where all datafiles/images a stored
cd(datapath); %propbably those two lines are necessary later in the batchfile to lead to our directory and not here anymore

session = 1; %change to number of runs (note - runs in SPM are sessions)

%Initialise SPM & SPM_Jobman defaults--> necessary to set up SPM can probably be put into batch script as well because it only needs to run
%once within one matlab session to execute any SPM functions and batch jobs
spm('defaults', 'FMRI');
spm_jobman('initcfg');

%%%%PREPROCESSING%%%%

%call realignment 
realignment();

%call realignment for the localizer
realignment_localizer

%call coregistration
coregistration();

%call segmentation
segmentation();

%call normalisation functional
normalisation_f();

%call normalisation structural
%normalisation_s();

%call smoothing
smoothing();

%%%%First-Level-Analysis%%%%

%call first-level-analysis
%first_level_analysis();

%%%%Second-Level-Analysis%%%%

%call second-level-analysis

