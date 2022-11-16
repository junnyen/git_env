#!/bin/zsh
if [ -z "$1" ]; then
	echo "Usage: show_runningcfg.sh [cfg.json]"
	echo "Exmaple:" 
	echo "	show_runningcfg.sh mxpsec"
elif [ "$1" = "all" ]; then
    jsons=($(ls /moxa/run/flask-moxa-config-layer/RunningConfig/))
    count=${#jsons[@]}
    touch all_cfg
    cat /dev/null > all_cfg
    for ((i=0;i<count;i++)); do 
        echo "[${jsons[i]}]" >> all_cfg
        python -m json.tool /moxa/run/flask-moxa-config-layer/RunningConfig/${jsons[i]} >> all_cfg
    done
else
	python -m json.tool /moxa/run/flask-moxa-config-layer/RunningConfig/$1.json
fi
