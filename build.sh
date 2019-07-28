#!/usr/bin/env bash

## general build stuff
apt update
apt install pkg-config build-essential wget curl nasm unzip git libglew-dev cuda-toolkit-10-1 python3-pip -y
pip3 install awscli

## install nv-codec-headers
git clone https://github.com/FFmpeg/nv-codec-headers.git
cd nv-codec-headers
make install
cd ..
rm -rf nv-codec-headers

## install ffmpeg
wget https://ffmpeg.org/releases/ffmpeg-4.1.4.tar.bz2
tar vjxf ffmpeg-4.1.4.tar.bz2
cd ffmpeg-4.1.4
./configure --enable-cuda --enable-cuvid --enable-nvenc --enable-nonfree --enable-libnpp --extra-cflags=-I/usr/local/cuda/include \
        --extra-ldflags=-L/usr/local/cuda/lib64
make -j 4
make install
cd ..
rm -rf ffmpeg-4.1.4
rm ffmpeg-4.1.4.tar.bz2
