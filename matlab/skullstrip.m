info = niftiinfo('/mnt/Data/liuy108/codes/ssresult/oasis45/label/1000_3_BC2_label.nii.gz');%label file path
label = niftiread(info);
label(find(label==210)) = 0;
label(find(label==209)) = 0;
label(find(label==208)) = 0;
niftiwrite(label,'/mnt/Data/liuy108/codes/ssresult/oasis45/ss/1000_3_label',info,'Compressed',true);
Img = zeros(size(label));

Img(find(label)) = 1;
SE = strel('cube',6);
J = imdilate(Img,SE);

info1 = niftiinfo('/mnt/Data/liuy108/codes/ssresult/oasis45/ss/1000_3.nii.gz');%image file path
Image = niftiread(info1);
Image(find(J==0)) = min(Image(:));
niftiwrite(Image,'/mnt/Data/liuy108/codes/ssresult/oasis45/ss/1000_3_ss',info1,'Compressed',true);


