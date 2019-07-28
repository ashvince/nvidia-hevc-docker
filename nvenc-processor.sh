#!/usr/bin/env bash

time aws s3 cp ${S3_INPUT_BUCKET}/${S3_INPUT_KEY} /mnt/${S3_INPUT_KEY}

FILENAME=$(echo "${S3_INPUT_KEY}" | cut -f 1 -d '.')

ffmpeg -hwaccel auto -i /mnt/${S3_INPUT_KEY} -f matroska -c:v hevc_nvenc -profile:v main10  -preset slow -pix_fmt yuv420p \
        -cq 19 -b:v 16000k -rc-lookahead:v 32  -c:a copy /mnt/${FILENAME}.mkv

time aws s3 cp /mnt/${FILENAME}.mkv ${S3_OUTPUT_BUCKET}
rm -rf /mnt/${FILENAME}.mkv