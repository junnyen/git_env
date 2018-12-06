#!/bin/bash
help ()
{
    echo "Usage: $0 [Old Pkg_Set.txt] [New Pkg_Set.txt]" 
    echo "Output: CHGLOG_[Old Pkg_Set.txt]_n_[New Pkg_Set.txt].txt"
    echo
}

if [ -z "$1" ] || [ -z "$2" ]; then
    help
    exit 1
fi

if [ ! -f "$1" ]; then
    echo "Error: $1 is not found."
elif [ ! -f "$2" ]; then
    echo "Error: $2 is not found."
fi

DIFF1=$1
DIFF2=$2
TRIM_FILE1=$(echo ${1%.*})
TRIM_FILE2=$(echo ${2%.*})
CODE_BASE="download/NET/MDS/4000/G4000/develop/source/"

DIFF_PKGS=($(diff -C1 ${DIFF1} ${DIFF2} | grep project | uniq | awk -F 'project' '{print $2}'))

CHG_LOG="CHGLOG_${TRIM_FILE1}_n_${TRIM_FILE2}.txt"
C_PATH=$(pwd)
CHG_LOG_PATH="${C_PATH}/${CHG_LOG}"
> ${C_PATH}/${CHG_LOG}

echo "***** ${DIFF1}" >> ${CHG_LOG_PATH}
echo "***** ${DIFF2}" >> ${CHG_LOG_PATH}
#echo -e "***** ${DIFF2}\r\n" >> ${CHG_LOG_PATH} 

for ((i=0;i<${#DIFF_PKGS[@]};i++)); do
    PKG=$(echo ${DIFF_PKGS[$i]} | awk -F '/' '{print $2}')
    echo ">>>>> ${PKG}"
    CMT_ID1=$(grep -A 1 ${PKG} ${DIFF1} | grep -v project)
    echo "CMT_ID1: ${CMT_ID1}"
    CMT_ID2=$(grep -A 1 ${PKG} ${DIFF2} | grep -v project)
    echo "CMT_ID2: ${CMT_ID2}"

    cd "${CODE_BASE}/$(echo ${DIFF_PKGS[$i]} | tr -d '\r')" 
    
    if [ "${CMT_ID1}" == "${CMT_ID2}" ]; then
        cd ${C_PATH}
        continue
    elif [ -z "${CMT_ID1}" ]; then
        echo "$(($i + 1)): ${DIFF_PKGS[$i]}" >> ${CHG_LOG_PATH} 
        git log --oneline --pretty="%h: %s -- %an" >> ${CHG_LOG_PATH}
    elif [ -z "${CMT_ID2}" ]; then
        echo "$(($i + 1)): ${DIFF_PKGS[$i]}" >> ${CHG_LOG_PATH} 
        echo "DELETED" >> ${CHG_LOG_PATH}
    else
        echo $(($i + 1)): ${DIFF_PKGS[$i]} >> ${CHG_LOG_PATH} 
        git log --oneline --pretty="%h: %s -- %an"  ${CMT_ID1::(5)}..${CMT_ID2::(5)} >> ${CHG_LOG_PATH}
    fi
    echo "-------------------------------------------------" >> ${CHG_LOG_PATH}
    cd ${C_PATH}
done

echo "Total Difference: ${#DIFF_PKGS[@]}" >> ${CHG_LOG_PATH}
exit 0 
