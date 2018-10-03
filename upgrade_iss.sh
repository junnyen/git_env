#!/bin/bash
scp moxa@192.168.127.1:/tmp/app-moxa-iss*.deb /tmp/
sudo dpkg -i /tmp/app-moxa-iss*.deb 

