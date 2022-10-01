#!/bin/bash


declare -A values

values=([1]=1 [2]=2 [3]=3 [4]=4 [5]=5 [6]=6 [7]=7 [8]=8 [9]=9)

echo -e "\n"
echo -e "\t     |     |"
echo -e "\t  "${values[1]}"  |  "${values[2]}"  |  "${values[3]}""
echo -e "\t_____|_____|_____"
echo -e "\t     |     |"
echo -e "\t  "${values[4]}"  |  "${values[5]}"  |  "${values[6]}""
echo -e "\t_____|_____|_____"
echo -e "\t     |     |"
echo -e "\t  "${values[7]}"  |  "${values[8]}"  |  "${values[9]}""
echo -e "\t     |     |"
echo -e "\n"









