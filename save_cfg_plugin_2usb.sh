#!/bin/bash
NAME=$(whoami)
OUTPUT="cfg_plugin_in_usb.txt"

if [ "${NAME}" != "root" ]; then
	echo "Error: Please execute this file by 'sudo'"
	echo "       > sudo $0"
	exit 1
fi

echo -n "Mount /dev/sdb1 to /mnt... "
umount /mnt > /dev/null 2>&1
mount /dev/sdb1 /mnt
if [ $? -ne 0 ]; then
	echo "Error: mount USB device failed."
	exit 1
fi
echo "done"

echo -n "Copy Config Plugin... "
cp /etc/moxa/flask-moxa-config-layer/Plugin/plugin_* /mnt
if [ $? -ne 0 ]; then
	echo "Error: Unexpected Failed."
	exit 1
fi
echo "done"

ls /mnt/plugin_* > ${OUTPUT}

echo -n "Unmount /mnt... "
umount /mnt > /dev/null 2>&1
echo "done"

echo "Output File: ${OUTPUT}"

exit 0
