#!/bin/bash

#!/bin/sh

/opt/slant/matlab/run_Deep_brain_preprocessing
python3 /opt/slant/dl/python/train.py --piece 1_1_1
python3 /opt/slant/dl/python/train.py --piece 1_1_2
python3 /opt/slant/dl/python/train.py --piece 1_1_3
python3 /opt/slant/dl/python/train.py --piece 1_2_1
python3 /opt/slant/dl/python/train.py --piece 1_2_2
python3 /opt/slant/dl/python/train.py --piece 1_2_3
python3 /opt/slant/dl/python/train.py --piece 1_3_1
python3 /opt/slant/dl/python/train.py --piece 1_3_2
python3 /opt/slant/dl/python/train.py --piece 1_3_3
python3 /opt/slant/dl/python/train.py --piece 2_1_1
python3 /opt/slant/dl/python/train.py --piece 2_1_2
python3 /opt/slant/dl/python/train.py --piece 2_1_3
python3 /opt/slant/dl/python/train.py --piece 2_2_1
python3 /opt/slant/dl/python/train.py --piece 2_2_2
python3 /opt/slant/dl/python/train.py --piece 2_2_3
python3 /opt/slant/dl/python/train.py --piece 2_3_1
python3 /opt/slant/dl/python/train.py --piece 2_3_2
python3 /opt/slant/dl/python/train.py --piece 2_3_3
python3 /opt/slant/dl/python/train.py --piece 3_1_1
python3 /opt/slant/dl/python/train.py --piece 3_1_2
python3 /opt/slant/dl/python/train.py --piece 3_1_3
python3 /opt/slant/dl/python/train.py --piece 3_2_1
python3 /opt/slant/dl/python/train.py --piece 3_2_2
python3 /opt/slant/dl/python/train.py --piece 3_2_3
python3 /opt/slant/dl/python/train.py --piece 3_3_1
python3 /opt/slant/dl/python/train.py --piece 3_3_2
python3 /opt/slant/dl/python/train.py --piece 3_3_3
/opt/slant/matlab/run_Deep_brain_postprocessing

