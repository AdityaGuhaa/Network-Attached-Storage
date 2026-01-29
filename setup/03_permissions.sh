#!/bin/bash
sudo groupadd nasusers
sudo usermod -aG nasusers $USER
sudo chown -R root:nasusers /srv/nas
sudo chmod -R 2775 /srv/nas
