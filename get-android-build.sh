read -p "Container ID: " input

sudo docker container cp $input:/webrtc.tar.gz ./