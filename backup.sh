#!/bin/bash

mysql_user='root'
files_source="/var"
backup_folder="$(pwd)/backups"
database_folder="databases"
name_prefix="$(date +%Y-%m-%d-%H%M%S)-backup"
backup_file_name="${name_prefix}.tar.gz"
max_backups=4

### create required directories ###
mkdir -p "${backup_folder}" "${backup_folder}/${database_folder}"
mkdir -p "${backup_folder}/${name_prefix}"
cd "${backup_folder}"

### backup all databases ###
databases=$(mysql -u $mysql_user -e "SHOW DATABASES")

for db in $databases; do
   mysqldump -u $mysql_user $db > "${database_folder}/${db}.sql" 2> /dev/null 
done

### archive & compress all files and databases ###
tar -cvzf "files.tar.gz" "${files_source}"
mv "files.tar.gz" "${name_prefix}"
mv "${database_folder}" "${name_prefix}"
tar -cvzf "${backup_file_name}" "${name_prefix}"
rm -rf "${name_prefix}"


### delete old backups ###
number_of_backups=$(ls | wc -w)
if [ $number_of_backups -gt $max_backups ]; then
oldest_backup=$(ls -htr | head -n 1)
rm -rf $oldest_backup
fi
