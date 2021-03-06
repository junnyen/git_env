#!/bin/bash
OUTPUT_IMG="output/MDS/latest/image/"
IMG_F_NAME=$(ls ${OUTPUT_IMG} 2> /dev/null)
if [ -z "${IMG_F_NAME}" ]; then
    echo "Error: IMG is NOT found in output directory."
    exit 1
else
    echo ${IMG_F_NAME}" is found!!!"
fi

IMG_NAME=${IMG_F_NAME%.*}

. ./.config
echo "SBU: "${SBU}
echo "PRODUCT_LINE: "${PRODUCT_LINE}
echo "SERIES: "${SERIES}
echo "PROJECT: "${PROJECT}
echo "VERSION: "${VERSION}

PWD_PATH=$(pwd)
TARGET_PATH="download/${SBU}/${PRODUCT_LINE}/${SERIES}/${PROJECT}/${VERSION}/source/package"

echo "Currect path: "${PWD_PATH}
cd  ${TARGET_PATH}
echo 
echo -n "Extract commit id..."
repo forall -p -c git log -1 --format=%H > ${PWD_PATH}/pkg_set.txt
echo "done"

cd ${PWD_PATH}
cd ddk-git-repo
if [ $? -eq 0 ]; then
    echo 
    echo -n "Extract ddk-git-repo commit id..."
    echo >> ${PWD_PATH}/pkg_set.txt
    echo ddk-git-repo >> ${PWD_PATH}/pkg_set.txt
    git log -1 --format=%H >> ${PWD_PATH}/pkg_set.txt
    # keep ddk rev.
    cd ../
    echo >> ${PWD_PATH}/pkg_set.txt
    echo "ddk" >> ${PWD_PATH}/pkg_set.txt
    git log -1 --format=%H >> ${PWD_PATH}/pkg_set.txt
    echo "done"

    echo
    echo -n "Trim..."
    awk 'sub("$", "\r")' ${PWD_PATH}/pkg_set.txt > ${PWD_PATH}/${IMG_NAME}.txt
    echo "done"
#    sudo awk 'sub("$", "\r")' ${PWD_PATH}/pkg_set.txt > output/MDS/latest/${IMG_NAME}.txt
else
    echo "Error: ddk-git-repo folder not found."
fi

echo
echo "Output: "${IMG_NAME}.txt
sudo mv ${PWD_PATH}/${IMG_NAME}.txt ${PWD_PATH}/${OUTPUT_IMG}

exit 0
