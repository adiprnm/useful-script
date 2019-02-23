#!/bin/bash

# Set this value if your git repository is on different filesystem
# export GIT_DISCOVERY_ACROSS_FILESYSTEM=1

DIR_PATH="Your git repository path"
LOG_PATH="Your log path"
status=$(cd "$DIR_PATH" && git status | grep 'nothing to commit')

my_date=`date`

if [ "$status" != "nothing to commit, working tree clean" ]; then
	current_date=$(date +'%d_%m_%Y_%H_%M_%S')
	commit_message="backup_$current_date"	
	log_message="[BACKUP $my_date] Commit message: $commit_message"
 
	cd "$DIR_PATH"
	echo $log_message >> $LOG_PATH
	{
		git add .
        echo "########" >> $LOG_PATH
		git commit -m "$commit_message" >> $LOG_PATH
		git push -u origin master >> $LOG_PATH        
        echo "########" >> $LOG_PATH
	} &> /dev/null
else
    log_message="[BACKUP $my_date] Nothing to commit."
    echo $log_message >> $LOG_PATH
fi
