#!/bin/sh

sudo apt update
sudo apt install libopenblas-dev libblas-dev m4 cmake cython python3-yaml libatlas-base-dev -y
export ONNX_ML=1
cd ~ && git clone --recursive https://github.com/pytorch/pytorch
cd pytorch
sudo -E python3 setup.py install
python3 -m pip install --upgrade pip
python3 -m pip install torchvision
python3 -m pip install pandas
python3 -m pip install --upgrade Pillow
python3 -m pip install matplotlib
python3 -m pip install opencv-contrib-python
