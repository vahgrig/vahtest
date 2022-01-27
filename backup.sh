#!/bin/bash

# What to backup. 
backup_files=$1

# Where to backup to.
if [ $# -eq 1 ]
then
	dest="/home/vahgrig/backupfiles/"
else 
	dest=$2
fi
if [[ -d $dest ]]
then
	echo "ok"
else 
	echo "directory not exist, do you want to create it yes/no"
	read answer
	if [ $answer = "yes" ]
	then 
		mkdir $dest
	else
		exit 1
	fi
fi
 
# Create archive filename.
day="$(date +"%Y%m%d")"
filename=$(basename $backup_files)
archive_file="$filename-$day.tgz"

# Print start status message.
echo "Backing up $backup_files to $dest/$archive_file"
echo
echo
echo
# Backup the files using tar.
tar czf $dest/$archive_file $backup_files

# Print end status message.
echo
echo "Backup finished"
date
echo "###############################################################"
# Long listing of files in $dest to file sizes
ls -lh $dest

find $dest -type f -mtime +5 -delete 
