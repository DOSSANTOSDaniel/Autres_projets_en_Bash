#!/bin/bash
find /sys/bus/w1/devices/ -name "28-*" -exec cat {}/w1_slave \; | grep "t=" | awk -F "t=" '{print $2/1000}'
