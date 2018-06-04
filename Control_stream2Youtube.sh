#!/bin/bash

let "etat = 0"
let "stop = 0"

while true; do

    var=$(gpio -g read 4)

    if [ $var -eq 1 ]; then
        if [ $etat -eq 0 ]; then 
            echo "Streaming starting"
            let "stop = 1"
            ffmpeg -thread_queue_size 512 -f v4l2 -i /dev/video0 \
               -f s16le -i /dev/zero -strict experimental \
               -vcodec h264 -preset veryfast -crf 25 -pix_fmt yuv420p -g 60 -vb 820k -maxrate 820k -bufsize 820k -profile:v baseline \
               -r 30 -f flv "rtmp://a.rtmp.youtube.com/live2/"bmjs-5che-k090-1g3z"" &

        fi
        
        let "etat = 1"

    else
        if [ $stop -eq 1 ]; then
            let "etat = 0"
            id1=($(ps ax | grep ffmpeg | head -n1 | cut -d " " -f1))
            id2=($(ps ax | grep ffmpeg | head -n2 | cut -d " " -f1))
            kill -9 $id1
            kill -9 $id2
            echo "Stream down"
            let "stop = 0"
        fi

    fi
done
