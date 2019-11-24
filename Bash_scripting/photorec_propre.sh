#!/bin/bash

echo "en fin ne pas mettre le '/' !!!"

find $1 -type f -size -160k -exec rm -r "{}" \;

find $1 -empty -type d -delete

mkdir $1/PhotoRecup

find $1 -type f -exec cp -r "{}" $1/PhotoRecup/ \;

rm -rf $1/recup_dir.*
