#!/bin/bash
if [ -z "$1" ]; then 
	echo "Please input token"
	exit
fi
sudo python3 /usr/lib/python3/dist-packages/moxa_token_module/moxa_token.py -v -t $1 -i 127.0.0.1
