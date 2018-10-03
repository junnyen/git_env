#!/bin/bash
if ($(ls *txt | wc -l) -ne 0); then 
    echo "find FWR.txt file failed."
    echo "---------------------------"
    ls *txt
    echo "---------------------------"
    exit
fi
PKG_SET=$(ls *txt)
TARGET="manifest.xml"
PKGS=($(grep project ${PKG_SET} | awk -F ' ' '{print $2}'))

for ((i = 0; i < ${#PKGS[@]}; i++));
do
    echo "*** ${PKGS[i]}"
    tmp_data=($(grep -A 2 "${PKGS[i]}" ${PKG_SET} | tr -d '\r'))
    CMT_ID=${tmp_data[2]}
    echo "commit id="${CMT_ID}
#    PKG_NAME=$(echo ${PKGS[i]} | awk -F '/' '{print $2}')
    PKG_NAME=$(echo ${PKGS[i]%/*})
    echo ${PKG_NAME} 
    LINE_NUM=$(grep -n "${PKG_NAME}\"" ${TARGET} | awk -F ':' '{print $1}')
    FIXED_LINE=$(grep "${PKG_NAME}\"" ${TARGET} | sed "s/revision.*\"/revision=\"${CMT_ID}\"/g")
    if [ -z "${FIXED_LINE}" ]; then
        continue;
    fi
    echo ${LINE_NUM}: ${FIXED_LINE}
    sed -i "${LINE_NUM}c ${FIXED_LINE}" manifest.xml
    sed -i 's/^<pro/    <pro/g' manifest.xml
done
