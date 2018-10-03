#!/bin/bash
scp moxa@192.168.127.1:/tmp/app-moxa-cli*.deb /tmp/
sudo dpkg -i /tmp/app-moxa-cli*.deb 

