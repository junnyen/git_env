#!/bin/bash
if [ -z "$1" ]; then
	echo "Usage: show_runningcfg.sh [cfg.json]"
	echo "Exmaple:" 
	echo "	show_runningcfg.sh mxpsec"
else
	sudo python -m json.tool /moxa/run/flask-moxa-config-layer/RunningConfig/$1.json
fi
