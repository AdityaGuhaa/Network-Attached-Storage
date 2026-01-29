#!/bin/bash
sudo apt update
sudo apt install -y samba
sudo systemctl enable smbd
