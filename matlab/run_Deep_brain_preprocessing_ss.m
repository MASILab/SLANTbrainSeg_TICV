clc;clear;close all;
% for skull-strip
% test on local machine
extra_dir = '/opt/slant/extra';
mdir = '/opt/slant/matlab/output_pre'; 
target_dir = '/opt/slant/matlab/input_pre'; 
in_post_dir = '/opt/slant/matlab/input_post';
python_cmd = 'python';

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
sublist_label = dir([target_dir filesep '*label.nii.gz']);
sublist_label = clean_sublist(target_dir,sublist_label);

run_all_batch = [mdir filesep 'run_all_batches.sh'];

fp = fopen(run_all_batch,'w');

for si = 1:0.5*length(sublist)
    subFile = sublist(si).name;
    subFile_label = sublist_label(si).name;
    subName = get_basename(subFile);
    target_fname = [target_dir filesep subFile];
    target_fname_label = [target_dir filesep subFile_label];
    
    nii = load_untouch_nii_gz(target_fname_label);
    label = single(nii.img);
    label(find(label==210)) = 0;
    label(find(label==209)) = 0;
    label(find(label==208)) = 0;
    Img = zeros(size(label));

    Img(find(label)) = 1;
    SE = strel('cube',6);
    J = imdilate(Img,SE);
    
    nii = load_untouch_nii_gz(target_fname);
    Image = [];
    Image = single(nii.img); 
    Image(find(J==0)) = min(Image(:));
    nii.img = Image;
    target_fname_ss = [in_post_dir filesep subName '_ss.nii.gz'];
    save_untouch_nii_gz(nii,target_fname_ss);

    % tic;
    preproc_pipline(target_fname_ss, mdir, in);
    
    normed_dir = [mdir filesep subName];
    working_dir = [normed_dir filesep 'working_dir'];
    normed_file = [normed_dir filesep 'target_processed.nii.gz'];
    generate_python_batch(normed_file,working_dir,model_dir,python_cmd,extra_dir);    
    batch_file = [working_dir filesep 'test_all_pieces.sh'];    
    fprintf(fp,'bash %s\n',batch_file);
    
end

fclose(fp);

%/pythondir/miniconda/bin/python /extra/python/test.py --piece=1_1_1 --model_dir=/extra/model_dir --test_img_dir=/OUTPUTS/130114_T1w_acpc_dc_restore_1.25/working_dir/deep_learning --out_dir=/OUTPUTS/130114_T1w_acpc_dc_restore_1.25/working_dir/all_piece

