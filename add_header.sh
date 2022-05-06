#!/bin/bash
CONVERT_INPUT="/tmp/convert.input"
BR2_MOXA_PRODUCT_ID=$1
BR2_MOXA_PRODUCT_VERSION=$2
BR2_MOXA_PRODUCT_NAME=$3
BUILDTIME=$4
MOXA_BUILD_DIR=$5

HOST_DIR=/home/moxa/${MOXA_BUILD_DIR}/buildroot/output/host
BINARIES_DIR=/home/moxa/${MOXA_BUILD_DIR}/buildroot/output/images

### Add rom header to SWU file
if [ -f ${CONVERT_INPUT} ]; then
        rm -f ${CONVERT_INPUT};
fi
touch ${CONVERT_INPUT}
echo \"PRODUCT_ID\": \"${BR2_MOXA_PRODUCT_ID}\" >> ${CONVERT_INPUT}
echo \"PRODUCT_VERSION\": \"${BR2_MOXA_PRODUCT_VERSION}\" >> ${CONVERT_INPUT}
${HOST_DIR}/usr/bin/convert -i ${BINARIES_DIR}/FWR_${BR2_MOXA_PRODUCT_NAME}_v${BR2_MOXA_PRODUCT_VERSION}_${BUILDTIME}.swu -o ${BINARIES_DIR}/FWR_${BR2_MOXA_PRODUCT_NAME}_v${BR2_MOXA_PRODUCT_VERSION}_${BUILDTIME}.swu.header -p ${CONVERT_INPUT}


