#!/bin/bash

if [[ $# == 0 ]]
then
  echo -e "\n Attention il faut une option \n"
  echo -e "Exemple : ${0} /home/mangkone/files/video.avi \n" 
else
  ffmpeg -nostdin -i ${1} -c:v copy -c:a copy -y ${1}.mp4     	
fi
