clc;clear;close all;

% test on local machine
extra_dir = '/opt/slant/extra';
mdir = '/opt/slant/matlab/output_pre'; 
target_dir = '/opt/slant/matlab/input_pre'; 
python_cmd = 'python';

% extra_dir = '/media/ethanyue/Yue/201910-202110academic/SLANT/xiongy2/docker/extra';
% mdir = '/media/ethanyue/Yue/201910-202110academic/SLANT/SLANTbrainSeg-master/matlab/output_pre'; 
% target_dir = '/media/ethanyue/Yue/201910-202110academic/SLANT/SLANTbrainSeg-master/matlab/input_pre'; 
% python_cmd = 'python';

% run on docker
% extra_dir = '/extra';
% mdir = '/OUTPUTS'; 
% target_dir = '/INPUTS'; 
% python_cmd = '/pythondir/miniconda/bin/python';

% set up locations
in.atlas_loc = [extra_dir filesep 'full-multi-atlas' filesep 'atlas-processing' filesep];
in.ants_loc = [extra_dir filesep 'full-multi-atlas' filesep 'ANTs-bin' filesep];
in.mni_loc = [extra_dir filesep 'full-multi-atlas' filesep 'MNI' filesep];
in.niftyreg_loc =  [extra_dir filesep 'full-multi-atlas' filesep 'niftyreg' filesep 'bin' filesep];

% model to learn from 
model_dir = [extra_dir filesep 'model_dir'];

sublist = dir([target_dir filesep '*.nii.gz']);
sublist = clean_sublist(target_dir,sublist);

run_all_batch = [mdir filesep 'run_all_batches.sh'];

fp = fopen(run_all_batch,'w');

for si = 1:length(sublist)
    subFile = sublist(si).name;
    subName = get_basename(subFile);
    target_fname = [target_dir filesep subFile];
    % tic;
    preproc_pipline(target_fname, mdir, in);
    
    normed_dir = [mdir filesep subName];
    working_dir = [normed_dir filesep 'working_dir'];
    normed_file = [normed_dir filesep 'target_processed.nii.gz'];
    generate_python_batch(normed_file,working_dir,model_dir,python_cmd,extra_dir);    
    batch_file = [working_dir filesep 'test_all_pieces.sh'];    
    fprintf(fp,'bash %s\n',batch_file);
    
end

fclose(fp);

%/pythondir/miniconda/bin/python /extra/python/test.py --piece=1_1_1 --model_dir=/extra/model_dir --test_img_dir=/OUTPUTS/130114_T1w_acpc_dc_restore_1.25/working_dir/deep_learning --out_dir=/OUTPUTS/130114_T1w_acpc_dc_restore_1.25/working_dir/all_piece
SubFolders = '/opt/slant/matlab/output_pre/FinalResult';
sub0 = GetFileNames(SubFolders,'*.nii.gz'); 
sub = sub0{1};
almost_nii = load_untouch_nii_gz(strcat('/opt/slant/matlab/output_pre/FinalResult/',sub));
almost_img = almost_nii.img;
almost_img = double(almost_img);
ind_nan = find(isnan(almost_img));
almost_img(ind_nan) = min(almost_img(:));
final_img = almost_img;
final_nii = almost_nii;
final_nii.img = final_img;
save_untouch_nii_gz(final_nii,strcat('/opt/slant/matlab/output_pre/FinalResult/',sub));
tprintf('Preprocessing Done');
tprintf('\n');

