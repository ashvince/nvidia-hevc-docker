FROM nvidia/cuda

ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility,video

COPY build.sh /root/build.sh
RUN /root/build.sh

## the following are optional if using ffmpeg for all video encoding
COPY Video_Codec_SDK_8.2.16.zip /root/Video_Codec_SDK_8.2.16.zip
RUN cd ~ && unzip Video_Codec_SDK_8.2.16.zip && cd Video_Codec_SDK_8.2.16/Samples && make
