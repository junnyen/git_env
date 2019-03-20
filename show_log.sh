#!/bin/bash
if [ -z "$1" ]; then
	echo "Usage: show_log.sh app_moxa_iss_init"
	exit -1
fi

if [ -n "$2" ]; then
#sudo journalctl -o short-precise -u app_moxa_iss_init --since "$1 sec ago"
sudo journalctl -o short-precise -u $1 --since "$2 sec ago"
#sudo journalctl -o short-precise -u app_moxa_cli --since "$1 sec ago"
else
sudo journalctl -o short-precise -fu $1 
#sudo journalctl -o short-precise -fu app_moxa_iss_init 
#sudo journalctl -o short-precise -fu systemd_app_moxa_iss_config_loader 
fi

