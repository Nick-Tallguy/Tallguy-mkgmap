#!/bin/bash
# 
DATE=$(date +"%Y-%m-%d")       
NME=ave-verte-large
DESC="Tallguy-Ave-Verte-Large"
FAMILYNME=Tallguy_ave_verte_large
GMAKE=/home/nick/mapping/mkgmap
GHUB=/home/nick/Github/Tallguy-mkgmap
MK_PROGS=${GHUB}/mkgmap-progs
POLY=${GHUB}/pbf-scripts/poly-files/ave-verte-12.poly
PBF=/home/nick/mapping/mkgmap/pbf_downloads/ave-verte-12.osm.pbf
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
        touch ${MAPS}/finished_local.txt
        exit 1
    fi
}
## Sorting the logging
exec 3>&1 1>${LOGFILE} 2>&1
trap "echo 'ERROR: An error occurred during execution, check log ${LOGFILE} for details.' >&3" ERR
trap '{ set +x; } 2>/dev/null; echo -n "[$(date -Is)] " set -x' DEBUG
#
echo "sorting the trash - about 100mins for map creation" $(date -u)
cd ${GENSCR}
./m93-space.sh
#
cd ${GMAKE}/work
#
## SPLITTER
rm -r ${GMAKE}/splitter/*
echo "starting splitter" $(date -u)
java -Xmx14g -jar ${MK_PROGS}/splitter-r654/splitter.jar --output=pbf --output-dir=${GMAKE}/splitter --max-nodes=1400000 --mapid=10010001 --geonames-file=${MK_PROGS}/cities15000.zip   --polygon-file=${POLY} ${PBF}
PROCESS_RETURN
#
sleep 10
### MKGMAP 
echo "Starting mkgmap" $(date -u)
rm -r ${GMAKE}/work/*
java -Xms1024m -Xmx14g  -jar ${MK_PROGS}/mkgmap-r4923/mkgmap.jar -c ${GHUB}/ave-verte/ave-verte.args --family-name=${FAMILYNME} -c ${GMAKE}/splitter/template.args --description="Tallguy-Ave-Verte-FR-Eng" ${NC_STYLES}/5405.txt --gmapsupp --gmapi --nsis
PROCESS_RETURN
##
sleep 20
echo "Smaller file size now .exe file with makensis " $(date -u)
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
mv ${GMAKE}/work/*.tdb ${MAPS}/${NME}-${DATE}.tdb
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