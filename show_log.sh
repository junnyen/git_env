#!/bin/bash
if [ -n "$1" ]; then
sudo journalctl -o short-precise -u app_moxa_iss_init --since "$1 sec ago"
else
#sudo journalctl -o short-precise -fu app_moxa_iss_init 
sudo journalctl -o short-precise -fu systemd_app_moxa_iss_config_loader 
fi

