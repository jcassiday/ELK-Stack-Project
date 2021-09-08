#!/bin/bash

free -mh > ~/Projects/backups/freemem/free_mem.txt
du -h > ~/Projects/backups/diskuse/disk_usage.txt
lsof > ~/Projects/backups/openlist/open_list.txt
df -h > ~/Projects/backups/freedisk/free_disk.txt
