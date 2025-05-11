#!/bin/bash
# 
DATE=$(date +"%Y-%m-%d")           
NME=barriers_filtered
DESC="Tallguy - barriers require attention"
FAMILYNME=Tallguy_barriers_filtered
GMAKE=/home/nick/mapping/mkgmap
NC_GMAKE=/home/nick/ncdata/mapping/Garmin
#AREA=testing
AREA=great-britain
POLY=${NC_GMAKE}/mkgmap-resources/${AREA}.poly
PBF=/home/nick/mapping/mkgmap/pbf_downloads
MAPS=/home/nick/mapping/QMS/Maps
TYPS=/home/nick/Github/Tallguy-mkgmap
NC_STYLES=${TYPS}/${NME}
LOGFILE=/home/nick/logs/${NME}-${DATE}.log
SCRIPTS=${TYPS}/gen-scripts
ZIPPED=/home/nick/7-zipped
#
## Sorting the logging
exec 3>&1 1>${LOGFILE} 2>&1
trap "echo 'ERROR: An error occurred during execution, check log ${LOGFILE} for details.' >&3" ERR
trap '{ set +x; } 2>/dev/null; echo -n "[$(date -Is)] " set -x' DEBUG
#
## Trash any existing o5m files
trash-put ${PBF}/*.o5m
echo "sorting the trash" $(date -u)
cd ${SCRIPTS}
./m93-space.sh
#
## OSMCONVERT  
osmconvert ${PBF}/${AREA}.osm.pbf --out-o5m >${PBF}/${AREA}.o5m
#
## OSMFILTER
#
osmfilter ${PBF}/${AREA}.o5m --parameter-file=${TYPS}/barriers_filtered/bar-parameters-1 -o=${PBF}/${AREA}-4.o5m     # bar-parameters-1 = highways except service, tracks and paths which are private or customers
osmfilter ${PBF}/${AREA}.o5m --parameter-file=${TYPS}/barriers_filtered/bar-parameters-2 -o=${PBF}/${AREA}-5.o5m     # bar-parameters-2 = Private Customer access areas without barriers
#
trash-put ${PBF}/${AREA}-?.osm.pbf
osmium merge ${PBF}/${AREA}-4.o5m ${PBF}/${AREA}-5.o5m -o${PBF}/${AREA}-6.osm.pbf
#
cd ${GMAKE}/work
#
## SPLITTER
rm -r ${GMAKE}/splitter/*
echo "starting splitter" $(date -u)
java -Xmx14g -jar ${NC_GMAKE}/mkgmap-progs/splitter-r654/splitter.jar --output=pbf --output-dir=${GMAKE}/splitter --max-nodes=1400000 --mapid=10010001 --geonames-file=${NC_GMAKE}/mkgmap-resources/cities15000.zip   --polygon-file=${POLY} ${PBF}/${AREA}-6.osm.pbf
#
### MKGMAP 
echo "Starting mkgmap" $(date -u)
rm -r ${GMAKE}/work/*
java -Xms1024m -Xmx14g  -jar ${NC_GMAKE}/mkgmap-progs/mkgmap-r4923/mkgmap.jar -c ${NC_STYLES}/nick.args --family-name=${FAMILYNME} -c ${GMAKE}/splitter/template.args --description="Tallguy - barriers require attention" ${NC_STYLES}/5401.txt --gmapsupp --gmapi --nsis
##
echo "Creating the windows .exe file with makensis" $(date -u)
makensis osmmap.nsi
cd ${ZIPPED}
echo "Zipping the windows file (needed for nextcloud)" $(date -u)
7z a ${ZIPPED}/${NME}-winexe-${DATE} ${GMAKE}/work/${FAMILYNME}.exe
echo "Creating torrent file" $(date -u)
transmission-create ${NME}-winexe-${DATE}.torrent -c ${DESC} -t udp://tracker.opentrackr.org:1337/announce -t https://tracker2.ctix.cn:443/announce https://tracker1.520.jp:443/announce ${ZIPPED}/${NME}-winexe-${DATE}.7z
echo "copying .exe files folder to dietpi" $(date -u)
scp -r -P 22 ${ZIPPED}/${NME}-winexe-${DATE}* 192.168.0.19:/mnt/dietpi_userdata/downloads/
# 
echo "zipping gmapi files" $(date -u)
7z a ${ZIPPED}/${NME}-gmapi-${DATE} ${GMAKE}/work/${FAMILYNME}.gmap
echo "Creating gmapi torrent file" $(date -u)
transmission-create ${NME}-gmapi-${DATE}.7z.torrent -c ${DESC} -t udp://tracker.opentrackr.org:1337/announce -t https://tracker2.ctix.cn:443/announce https://tracker1.520.jp:443/announce ${ZIPPED}/${NME}-gmapi-${DATE}.7z
scp -r -P 22 ${ZIPPED}/${NME}-gmapi-${DATE}.* 192.168.0.19:/mnt/dietpi_userdata/downloads/
#
echo "moving gmapsupp to qmapshack map folder and renaming" $(date -u)
mv ${GMAKE}/work/gmapsupp.img ${MAPS}/${NME}-${DATE}.img
mv ${GMAKE}/work/*.tdb ${MAPS}/${NME}-${DATE}.tdb
#
echo "Creating 7z archive" $(date -u)
7z a ${ZIPPED}/${NME}-${DATE} ${MAPS}/${NME}-${DATE}.img ${MAPS}/${NME}-${DATE}.tdb
cd ${ZIPPED}
#
scp -P 22 ${ZIPPED}/${NME}-${DATE}.* 192.168.0.19:/mnt/dietpi_userdata/downloads/
#
echo "cleaning up - trashing files in 7-zipped folder and Maps folder" $(date -u)
trash-put ${ZIPPED}/*
trash-put ${MAPS}/*
echo "Files transferred to dietpi & all finished - torrent files commented out & sync not requested" $(date -u)
