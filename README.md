# bash-websites-backup-script

# basic usage:

first give the script permission to execute

$ chmod 700 backup.sh

and then run the script

$ ./backup.sh

or you can add it to crob jobs 

$ cron -e

append the following line 

0 0 * * * /path/to/your/backup.sh

now this script will run every day at 12:00 
