#!/bin/bash

echo "Backup Pictures"
rclone copy ~/Pictures gdrive:Pictures --progress --update

echo "Backup Videos"
rclone copy ~/Videos/ gdrive:Videos --progress --update
