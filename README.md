# SLANTbrainSeg_TICV

**We now maintain the Singularity image on [Zenodo](https://zenodo.org/) along with detailed instructions**, including:
- Expected input setup  
- Execution commands  
- Output format and directory structure  
- Sample data for testing reproducibility
  
1. Please see the full release: [non-skull-stripped SLANT_TICV](https://zenodo.org/records/14618566)
2. Please see the full release: [skull-stripped SLANT_TICV](https://zenodo.org/records/15272931)

To build new singularity image, please refer to build_singularity.txt and run:
sudo singularity build -F /path/nssSLANT.simg /path/build_singularity
in terminal. 
