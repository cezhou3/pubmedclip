#!/bin/bash

# <<<init conda>>>
source /workspace/misc/miniconda3/etc/profile.d/conda.sh

# create conda env
conda create -n pubmedclip python=3.7 -y
conda activate pubmedclip

# install requirements
cd ./PubMedCLIP
pip install -r requirements.txt
pip uninstall torch torchvision
pip install torch==1.10.0+cu111 torchvision==0.11.0+cu111 torchaudio==0.10.0 -f https://download.pytorch.org/whl/torch_stable.html