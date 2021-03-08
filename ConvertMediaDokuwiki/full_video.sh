#!/bin/bash

if [[ $# == 0 ]]
then
  echo -e "\n Attention il faut une option \n"
  echo -e "Exemple : ${0} /home/mangkone/files \n" 
else
  cd ${1}
  for video in *
  do
    ffmpeg -nostdin -i ${video} -c:v copy -c:a copy -y ${video}.mp4     	
  done
fi
