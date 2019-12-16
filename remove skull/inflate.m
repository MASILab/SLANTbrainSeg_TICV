phnsseg = ('seg.txt');
fpnseg = fopen(phnsseg, 'rt');

phnsT1 = ('T1.txt');
fpnT1 = fopen(phnsT1, 'rt');

phns = ('save.txt');
fpn = fopen(phns, 'rt');

while feof(fpnseg) ~=1 && feof(fpnT1) ~=1 && feof(fpnT1) ~=1
    fileseg = fgetl(fpnseg);
    fileT1 = fgetl(fpnT1);
    file = fgetl(fpn);
    
    nii = load_untouch_nii_gz(strcat(fileseg));
    Img = single(nii.img); 
    SE = strel('cube',4);
    J = imdilate(Img,SE);
    mask = zeros(size(J));

    mask(find(J)) = 1;

    
    nii = load_untouch_nii_gz(strcat(fileT1));
    Image = single(nii.img); 
    stripped = Image.*mask;
    nii.img = stripped;
    save_untouch_nii_gz(nii,strcat(file,'skullstripped.nii.gz'));
    

    %disp(file);
end



