#!/bin/bash
#
######   Deleting items from trash automatically.  
#
ALERT=35   # This figure in GB  IF SPACE AVAILABLE IS LOWER THAN 10gb, OUTPUT WILL NOT BE AN INTEGER! 
#
### 	Sort out trash	###
function SPC(){
# below line is for m93 - Lenovo
df -h | grep -vE '^Filesystem|tmpfs|efivarfs|tmpfs|tmpfs|/dev/sda2|/dev/sda1|tmpfs' | awk '{ print $4 " " $1 }' | while read -r output;
do
  echo "$output"
  usep=$(echo "$output" | awk '{ print $1}' | cut -d'G' -f1 )
#  partition=$(echo "$output" | awk '{ print $1 }' )
  if [ $usep -ge $ALERT ]
  then
  echo "There is enough space"
  exit 0
  else
  echo "Running out of space - emptying trash older than $N days"
  trash-empty $N
  fi
    done
    }
  #
  NUMBERS="32 16 8 4 2 1 0"
  for N in $NUMBERS
  do
  SPC
  done 

