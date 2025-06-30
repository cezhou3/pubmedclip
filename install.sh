#!/bin/bash

# <<<init conda>>>
source /workspace/misc/miniconda3/etc/profile.d/conda.sh

# create conda env
conda create -n pubmedclip python=3.7 -y
conda activate pubmedclip

# install requirements
cd ./PubMedCLIP
pip install -r requirements.txt
pip uninstall -y setuptools
pip install setuptools==59.5.0
pip install torch==1.13.1+cu117 torchvision==0.14.1+cu117 torchaudio==0.13.1 --extra-index-url https://download.pytorch.org/whl/cu117
pip install git+https://github.com/openai/CLIP.git
