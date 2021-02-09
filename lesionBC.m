nii = load_untouch_nii_gz('/home/liuy108/nfs/masi/liuy108/MS/WMHSegmentationChallenge/Utrecht/0/wmh.nii.gz');
label = single(nii.img);
ind1 = find(label==1);
ind2 = find(label==2);

nii = load_untouch_nii_gz('/home/liuy108/nfs/masi/liuy108/MS/WMHSegmentationChallenge/Utrecht/0/pre/T1_seg.nii.gz');
label1 = single(nii.img);
label1(ind1) = 212;
label1(ind2) = 213;

nii.img = label1;
target_fname_ss = '/home/liuy108/nfs/masi/liuy108/MS/WMHSegmentationChallenge/Utrecht/0/pre/lesionBC_seg.nii.gz';
save_untouch_nii_gz(nii,target_fname_ss);