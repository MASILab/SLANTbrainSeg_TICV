# SLANTbrainSeg_skullstripped
You can get skull-stripped brain by running 'inflate.m' in 'remove skull'. Image directories are listed in text files.

Get singularity image
1. non-skull-stripped SLANT
https://drive.google.com/file/d/1ulQzaPlp1oOVBJK955ZETw0w3DEc8ztE/view?usp=sharing
2. skull-stripped SLANT
https://drive.google.com/file/d/1zmjHiLxrrODOjFXBZBNQ9iPdbnwj-1Zw/view?usp=sharing

Run sigularity image
1. non-skull-stripped SLANT

create directories:
#put raw input image
/local/in  
#generated output files
/local/out/dl
/local/out/pre
/local/out/post  # final result folder

Run container
singularity exec -B /local/in:/opt/slant/matlab/input_pre -B /local/in:/opt/slant/matlab/input_post -B /local/out/pre:/opt/slant/matlab/output_pre -B /local/out/dl:/opt/slant/dl/working_dir -B /local/out/post:/opt/slant/matlab/output_post -e ./nssSLANT_v1.0.simg /opt/slant/run.sh

2. skull-stripped SLANT

create directories:
#put skull-stripped input image
/local/in  
#generated output files
/local/out/dl
/local/out/pre
/local/out/post  # final result folder

Run container
singularity exec -B /local/in:/opt/slant/matlab/input_pre -B /local/in:/opt/slant/matlab/input_post -B /local/out/pre:/opt/slant/matlab/output_pre -B /local/out/dl:/opt/slant/dl/working_dir -B /local/out/post:/opt/slant/matlab/output_post -e ./ssSLANT_v1.0.simg /opt/slant/run.sh
