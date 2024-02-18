#!/bin/bash
#
#####
#                             README BEFORE MAKING ANY CHANGES 
#                            ###################################
#
#  This produces a 'sync snippet' to insert into a script
#
DATE=$(date +"%Y-%m-%d")
MAPS=/home/nick/mapping/QMS/Maps
ZIPPED=/home/nick/7-zipped
#
touch ${ZIPPED}/map-sync-needed.txt
scp -P 22 ${ZIPPED}/map-sync-needed.txt nick@daphne-nick.uk:/mnt/dietpi_userdata/downloads/
trash-put ${ZIPPED}/map-sync-needed.txt 
echo "Sync request has been uploaded to dietpi" $(date -u)
