#!/bin/bash
# 
############################### Electric Wheelchair L=1.36, W=0.72
DATE=$(date +"%Y-%m-%d")           
NME=electric_wheelchair
DESC="Tallguy - electric wheelchair"
FAMILYNME=Tallguy_electric_wheelchair
GMAKE=/home/nick/mapping/mkgmap
GHUB=/home/nick/Github/Tallguy-mkgmap
NC_GMAKE=/home/nick/ncdata/mapping/Garmin
AREA=great-britain
#AREA=testing
POLY=${GHUB}/pbf-scripts/poly-files/${AREA}.poly
PBF=/home/nick/mapping/mkgmap/pbf_downloads
MAPS=/home/nick/mapping/QMS/Maps
NC_STYLES=${GHUB}/${NME}
LOGFILE=/home/nick/logs/${NME}-${DATE}.log
GENSCR=${GHUB}/gen-scripts
ZIPPED=${GMAKE}/7-zipped
#
PROCESS_RETURN() {
    if [ $? -eq 0 ]
    then 
        echo "Success" $(date -u)
    else
        echo "Failed script at this point" $(date -u)
        exit 1
    fi
}
## Sorting the logging
exec 3>&1 1>${LOGFILE} 2>&1
trap "echo 'ERROR: An error occurred during execution, check log ${LOGFILE} for details.' >&3" ERR
trap '{ set +x; } 2>/dev/null; echo -n "[$(date -Is)] " set -x' DEBUG
#
## Trash any existing o5m files
trash-put ${PBF}/*.o5m
echo "sorting the trash" $(date -u)
cd ${GENSCR}
./m93-space.sh
#
## OSMCONVERT  
osmconvert ${PBF}/${AREA}.osm.pbf --out-o5m >${PBF}/${AREA}.o5m
PROCESS_RETURN
#
## OSMFILTER
#
osmfilter ${PBF}/${AREA}.o5m --parameter-file=${GHUB}/barriers_filtered/bar-parameters-1 -o=${PBF}/${AREA}-4.o5m     # bar-parameters-1 = highways except service, tracks and paths which are private or customers
PROCESS_RETURN
osmfilter ${PBF}/${AREA}.o5m --parameter-file=${GHUB}/barriers_filtered/bar-parameters-2 -o=${PBF}/${AREA}-5.o5m     # bar-parameters-2 = Private Customer access areas without barriers
PROCESS_RETURN
#
trash-put ${PBF}/${AREA}-?.osm.pbf
osmium merge ${PBF}/${AREA}-4.o5m ${PBF}/${AREA}-5.o5m -o${PBF}/${AREA}-6.osm.pbf
PROCESS_RETURN
#
cd ${GMAKE}/work
#
## SPLITTER
rm -r ${GMAKE}/splitter/*
echo "starting splitter" $(date -u)
java -Xmx14g -jar ${GHUB}/mkgmap-progs/splitter-r654/splitter.jar --output=pbf --output-dir=${GMAKE}/splitter --max-nodes=1400000 --mapid=10010001 --geonames-file=${GHUB}/mkgmap-progs/cities15000.zip   --polygon-file=${POLY} ${PBF}/${AREA}-6.osm.pbf
PROCESS_RETURN
#
### MKGMAP 
echo "Starting mkgmap" $(date -u)
rm -r ${GMAKE}/work/*
java -Xms1024m -Xmx14g  -jar ${GHUB}/mkgmap-progs/mkgmap-r4923/mkgmap.jar -c ${NC_STYLES}/nick.args --family-name=${FAMILYNME} -c ${GMAKE}/splitter/template.args --description="Tallguy - electric wheelchair" ${NC_STYLES}/5411.txt --gmapsupp  --gmapi --nsis
PROCESS_RETURN
##
echo "Creating the windows .exe file with makensis" $(date -u)
makensis osmmap.nsi
PROCESS_RETURN
cd ${ZIPPED}
echo "Zipping the windows file (needed for nextcloud)" $(date -u)
7z a ${ZIPPED}/${NME}-winexe-${DATE} ${GMAKE}/work/${FAMILYNME}.exe
PROCESS_RETURN
echo "Creating torrent file" $(date -u)
transmission-create ${NME}-winexe-${DATE}.torrent -c ${DESC} -t udp://tracker.opentrackr.org:1337/announce -t https://tracker2.ctix.cn:443/announce https://tracker1.520.jp:443/announce ${ZIPPED}/${NME}-winexe-${DATE}.7z
PROCESS_RETURN
# 
echo "zipping gmapi files" $(date -u)
7z a ${ZIPPED}/${NME}-gmapi-${DATE} ${GMAKE}/work/${FAMILYNME}.gmap
PROCESS_RETURN
echo "Creating gmapi torrent file" $(date -u)
transmission-create ${NME}-gmapi-${DATE}.7z.torrent -c ${DESC} -t udp://tracker.opentrackr.org:1337/announce -t https://tracker2.ctix.cn:443/announce https://tracker1.520.jp:443/announce ${ZIPPED}/${NME}-gmapi-${DATE}.7z
PROCESS_RETURN
#
echo "moving gmapsupp to qmapshack map folder and renaming" $(date -u)
mv ${GMAKE}/work/gmapsupp.img ${MAPS}/${NME}-${DATE}.img
PROCESS_RETURN
mv ${GMAKE}/work/*.tdb ${MAPS}/${NME}-${DATE}.tdb
PROCESS_RETURN
#
echo "Creating 7z archive" $(date -u)
7z a ${ZIPPED}/${NME}-${DATE} ${MAPS}/${NME}-${DATE}.img ${MAPS}/${NME}-${DATE}.tdb
PROCESS_RETURN
cd ${ZIPPED}
#
#######  Sending the files to dietpi & then trashing
cd ${GENSCR}
./send.sh
PROCESS_RETURN
echo "${NME} map safely completed" $(date -u)
