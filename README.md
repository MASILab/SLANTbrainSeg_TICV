# SLANTbrainSeg_TICV
You can get skull-stripped brain by running 'inflate.m' in 'remove skull'. Image directories are listed in text files.

Get singularity image
1. non-skull-stripped SLANT
https://drive.google.com/file/d/1f0Kyfw7RH84kt7wi_Y5eRWBVZ_YPFYMd/view?usp=share_link
2. skull-stripped SLANT
https://drive.google.com/file/d/1zmjHiLxrrODOjFXBZBNQ9iPdbnwj-1Zw/view?usp=sharing

Run sigularity image
1. non-skull-stripped SLANT

create directories:

/local/in  #put raw input image

/local/out/dl  #generated output files

/local/out/pre  #generated output files 

/local/out/post  # final result folder

Run container
singularity exec --nv -B /local/in:/opt/slant/matlab/input_pre -B /local/in:/opt/slant/matlab/input_post -B /local/out/pre:/opt/slant/matlab/output_pre -B /local/out/dl:/opt/slant/dl/working_dir -B /local/out/post:/opt/slant/matlab/output_post -e ./nssSLANT_v1.1.simg /opt/slant/run.sh

2. skull-stripped SLANT

create directories:

/local/in  #put raw input image

/local/out/dl  #generated output files

/local/out/pre  #generated output files 

/local/out/post  # final result folder

Run container
singularity exec -B /local/in:/opt/slant/matlab/input_pre -B /local/in:/opt/slant/matlab/input_post -B /local/out/pre:/opt/slant/matlab/output_pre -B /local/out/dl:/opt/slant/dl/working_dir -B /local/out/post:/opt/slant/matlab/output_post -e ./ssSLANT_v1.0.simg /opt/slant/run.sh
