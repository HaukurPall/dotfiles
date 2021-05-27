#!/bin/bash
wget https://repo.anaconda.com/miniconda/Miniconda3-py39_4.9.2-Linux-x86_64.sh -O ~/miniconda.sh
bash ~/miniconda.sh -b -p $CONDA_HOME
rm ~/miniconda.sh