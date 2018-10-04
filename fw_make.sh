#!/bin/bash
echo "  1. Base Image"
echo "  2. Diff Image"
echo "  3. Diff Image + MP"
read -r -p "Please choose the make image type [1/2/3]: " choice
case $choice in
    [1])
        echo "Start Building BASE Image..."
        unset DIFF
        ;;
    [2])
        echo "Start Building Diff Image..."
        DIFF="DIFF=YES BASE=0.1"
        ;;
    [3])
        echo "Start Building Diff Image including MP..."
        DIFF="DIFF=YES BASE=0.1 MP=YES"
        ;;
    *)
        ;;
esac

echo "command: make image ${DIFF}"
LOG=$(date +"%Y_%m%d")".log"
echo "Log File: "${LOG}

# Checking Disk Space
AVAILABLE_SPACE=$(df -h | grep sda1 | awk -F " " '{print $5}'  | tr -d "\%")

echo "Avaiable Space in root is ${AVAILABLE_SPACE}"
if [ ${AVAILABLE_SPACE} -gt 90 ]; then
    echo "Disk space may not be enough."
    read -r -p "Are you sure? [y/N] " response
    case $response in
    [yY][eE][sS]|[yY]) 
        echo "Build Image..."
        ;;
    [nN][oO]|[nN]) 
        exit 1
        ;;
    *)
        ;;
    esac
fi

# Download Source Code
echo ${LOG}
echo "sync_source" >> ${LOG}
date +%s >> ${LOG}
date >> ${LOG}
make sync_source_by_local_manifest
if [ $? -eq 0 ]; then
    date +%s >> ${LOG}
    date >> ${LOG}
else
    date +%s >> ${LOG}
    date >> ${LOG}
    echo "make sync source FAILED!"
    exit 1
fi

# Dependency Construct
echo "make prepate" >> ${LOG}
date +%s >> ${LOG}
date >> ${LOG}
make prepare
if [ $? -eq 0 ]; then
    date +%s >> ${LOG}
    date >> ${LOG}
else
    date +%s >> ${LOG}
    date >> ${LOG}
    echo "make prepare FAILED!"
    exit 1
fi

# Build Image
echo "make image ${DIFF}" >> ${LOG}
date +%s >> ${LOG}
date >> ${LOG}
make image ${DIFF}
if [ $? -eq 0 ]; then
    date +%s >> ${LOG}
    date >> ${LOG}
else
    date +%s >> ${LOG}
    date >> ${LOG}
    echo "make image FAILED!"
    exit 1
fi

exit 0

