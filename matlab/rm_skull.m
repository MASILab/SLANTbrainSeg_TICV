nii = load_untouch_nii_gz('/opt/slant/matlab/input_pre/*.nii.gz');
Image = single(nii.img); 
Img = zeros(size(Image));

Img(find(Image)) = 1;
SE = strel('cube',12);
J = imdilate(Img,SE);
%mask = zeros(size(J));
%     %Image = Img(100,:,:);
%mask(find(J)) = 1;
%     nii.img = mask;    
%     save_untouch_nii_gz(nii,strcat(file));
% nii.img = J;
% save_untouch_nii_gz(nii,'inflate.nii.gz');

nii = load_untouch_nii_gz(strcat('/home/liuy108/nfs/masi/liuy108/rawSLANT/finetune_training/aladin-reg-images-normalized/average305_t1_tal_lin_via_',num2str(i),'_3.nii.gz'));
%nii = load_untouch_nii_gz(strcat('/mnt/Data/liuy108/codes/ssresult/oasis27/T1/',num2str(i),'_3.nii.gz'));
Image = [];
Image = single(nii.img); 
Image(find(J==0)) = min(Image(:));
%Image(find(J==0)) = 0;
%stripped = Image.*mask;
%nii.img = stripped;
nii.img = Image;
%save_untouch_nii_gz(nii,strcat('/home/liuy108/nfs/masi/liuy108/procSLANT0/testing_135/image/average305_t1_tal_lin_via_',num2str(i),'_3.nii.gz'));
save_untouch_nii_gz(nii,strcat('/mnt/Data/liuy108/codes/procSLANT1/12/',num2str(i),'_3.nii.gz'));
