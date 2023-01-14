function save_untouch_nii_gz(nii, fileprefix, varargin)
% SAVE_NII_GZ - Saves a *.nii.gz file in matlab.
%
% There are two different forms of this function:
%
% 1 - save_nii_gz(nii, filenameIN)
% 2 - save_nii_gz(nii, filenameIN, filesuffix)
%
% Input: nii - the nifti struct
%        filenameIN - the .nii.gz file to load
%        filesuffix (opt) - an explicit filename suffix to add to the
%                           temporary file that is saved. This may be necessary
%                           if loading multiple files simultaneously as the
%                           default suffix is a pseudo-random number.
%

% set the temporary filename
if isempty(varargin)
    pid = int32(feature('getpid'));
    randnum = num2str(round(rand()*1e8));
    [filepath,name,ext] = fileparts(fileprefix);
    filename = [filepath filesep name];
else
    filename = ['/tmp/tmp', varargin{1}, '.nii'];
end

% try to save the temporary file
save_untouch_nii(nii,filename);

% zip the temporary file to its final location
gzip(filename);

% delete the temporary file
delete(filename);

