#!/bin/bash
if [ -z "$1" ]; then
sudo journalctl -u app_moxa_iss_init
else
sudo journalctl -fu app_moxa_iss_init
fi
