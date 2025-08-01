#!/bin/bash
# 
DATE=$(date +"%Y-%m-%d")            #
NME=canal
DESC="Tallguy - canal"
FAMILYNME=Tallguy-Canal
GMAKE=/home/nick/mapping/mkgmap
#AREA=great-britain
AREA=testing
POLY=${NC_GMAKE}/mkgmap-resources/${AREA}.poly
NC_GMAKE=/home/nick/ncdata/mapping/Garmin
PBF=/home/nick/mapping/mkgmap/pbf_downloads/${AREA}.osm.pbf
MAPS=/home/nick/mapping/QMS/Maps
TYPS=/home/nick/Github/Tallguy-mkgmap
NC_STYLES=${TYPS}/${NME}
LOGFILE=/home/nick/logs/${NME}-${DATE}.log
SCRIPTS=${TYPS}/gen-scripts
ZIPPED=${GMAKE}/7-zipped
#
## Sorting the logging
exec 3>&1 1>${LOGFILE} 2>&1
trap "echo 'ERROR: An error occurred during execution, check log ${LOGFILE} for details.' >&3" ERR
trap '{ set +x; } 2>/dev/null; echo -n "[$(date -Is)] " set -x' DEBUG
#
echo "sorting the trash" $(date -u)
cd ${SCRIPTS}
#./m93-space.sh
#
cd ${GMAKE}/work
#
## SPLITTER
rm -r ${GMAKE}/splitter/*
echo "starting splitter" $(date -u)
java -Xmx14g -jar ${NC_GMAKE}/mkgmap-progs/splitter-r654/splitter.jar --output=pbf --output-dir=${GMAKE}/splitter --max-nodes=1400000 --mapid=10010001 --geonames-file=${NC_GMAKE}/mkgmap-resources/cities15000.zip   --polygon-file=${NC_GMAKE}${POLY} ${PBF}
#
### MKGMAP 
echo "Starting mkgmap" $(date -u)
rm -r ${GMAKE}/work/*
java -Xms1024m -Xmx14g  -jar ${NC_GMAKE}/mkgmap-progs/mkgmap-r4923/mkgmap.jar -c ${NC_STYLES}/nick.args --family-name=${FAMILYNME} -c ${GMAKE}/splitter/template.args --description="Tallguy - canal" ${NC_STYLES}/5410.txt --gmapsupp ##  --gmapi --nsis   
##
##
#echo "Creating the windows .exe file with makensis" $(date -u)
#makensis osmmap.nsi
#cd ${ZIPPED}
#echo "Zipping the windows file" $(date -u)
#7z a ${ZIPPED}/${NME}-winexe-${DATE} ${GMAKE}/work/${FAMILYNME}.exe
#echo "Creating torrent file" $(date -u)
#transmission-create ${NME}-winexe-${DATE}.torrent -c ${DESC} -t udp://tracker.opentrackr.org:1337/announce -t https://tracker2.ctix.cn:443/announce https://tracker1.520.jp:443/announce ${ZIPPED}/${NME}-winexe-${DATE}.7z
# 
#echo "zipping gmapi files" $(date -u)
#7z a ${ZIPPED}/${NME}-gmapi-${DATE} ${GMAKE}/work/${FAMILYNME}.gmap
#echo "Creating gmapi torrent file" $(date -u)
#transmission-create ${NME}-gmapi-${DATE}.7z.torrent -c ${DESC} -t udp://tracker.opentrackr.org:1337/announce -t https://tracker2.ctix.cn:443/announce https://tracker1.520.jp:443/announce ${ZIPPED}/${NME}-gmapi-${DATE}.7z
#
#echo "moving gmapsupp to qmapshack map folder and renaming" $(date -u)
#mv ${GMAKE}/work/gmapsupp.img ${MAPS}/${NME}-${DATE}.img
#mv ${GMAKE}/work/*.tdb ${MAPS}/${NME}-${DATE}.tdb
#
#echo "Creating 7z archive" $(date -u)
#7z a ${ZIPPED}/${NME}-${DATE} ${MAPS}/${NME}-${DATE}.img ${MAPS}/${NME}-${DATE}.tdb
#cd ${ZIPPED}
#
#
#echo "copying 7-zipped folder contents to destination" $(date -u)
#cd ${NC_GMAKE}/hidden-scripts
#./send.sh
#
#echo "sorting the file sync on destination" $(date -u)
#cd ${SCRIPTS}
#./mk-sync-needed.sh
##
#echo "cleaning up - trashing files in 7-zipped folder and Maps folder" $(date -u)
#trash-put ${ZIPPED}/*
#trash-put ${MAPS}/*
echo "Files transferred to destination & all finished" $(date -u)


