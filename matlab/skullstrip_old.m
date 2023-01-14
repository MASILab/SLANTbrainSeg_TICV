% nii = load_untouch_nii_gz('/mnt/Data/liuy108/codes/ssresult/oasis45/label/1000_3_BC2_label.nii.gz');
% label = single(nii.img);
% label(find(label==210)) = 0;
% label(find(label==209)) = 0;
% label(find(label==208)) = 0;
% Img = zeros(size(label));
% 
% Img(find(label)) = 1;
% SE = strel('cube',6);
% J = imdilate(Img,SE);
% 
% nii = load_untouch_nii_gz('/mnt/Data/liuy108/codes/ssresult/oasis45/T1orig/1000_3.nii.gz');
% Image = [];
% Image = single(nii.img); 
% Image(find(J==0)) = min(Image(:));
% nii.img = Image;
% target_fname_ss = '/mnt/Data/liuy108/codes/ssresult/oasis45/ss/1000_3_ss.nii.gz';
% save_untouch_nii_gz(nii,target_fname_ss);