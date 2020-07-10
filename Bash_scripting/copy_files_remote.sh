#!/bin/bash
rsync -avrz --progress --stats /var/www/html/codiad/ daniel@192.168.0.15:/home/daniel/BACKUPS/
