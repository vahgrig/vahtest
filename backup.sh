#!/bin/bash


if [ $# -eq 0 ] 
then 
	echo
	echo "error:please input directory for backup"
	echo
	exit 1
fi
if [ $# -eq 1 ]
then
	dest="/home/backupfiles"
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

backup_files=$1



#time="$(date +"%Y-%m %d")"
filename=$(basename $backup_files)
archive_file="$filename-$(date +"%Y-%m-%d").tgz"


echo "Backing up $backup_files to $dest/$archive_file"


tar czf $dest/$archive_file $backup_files

echo "backup is finished"


echo "#######################END########################################"
ls -lh $dest

#find $dest -type f -mtime +5 -delete
