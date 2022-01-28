#!/bin/bash
#checking arguments
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
	echo 
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
#geting curent last created file name
cd $dest
last_file_name="$(ls -tr | tail -n 1)"
#creating file name
#time="$(date +"%Y-%m %d")"
filename=$(basename $backup_files)
archive_file="$filename-$(date +"%Y-%m-%d-%H-%M-%S").tgz"
gzip -r -c  $backup_files>$dest/$archive_file
curent_created_file="$(ls -tr | tail -n 1)"
echo "backup is finished"
ls -lh $dest
#checking buckup file modifed or not 
if [ $(ls | wc -l) -gt 1 ]
then
	if [ "$(curl --silent $last_file_name | md5sum)" = "$(curl --silent $curent_created_file | md5sum)" ]
	then 
		echo "deleting file"
		rm -f $curent_created_file
	else
		echo "modified file"
	fi
#deleting older files except last 5 created files 
	if [ $(ls | wc -l) -gt 1 ]
	then
		while [ $(ls | wc -l) -gt 5 ]
		do 
			rm -f $(ls -t | tail -1)
		done
	fi
fi
#find $dest -type f -mtime +5 -delete
