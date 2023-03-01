#!/bin/bash

# Set up some variables
MYSQL_USERNAME="backup"
MYSQL_PASSWORD="Gv3fMh8qYq3M7tD5"
BACKUP_DIR="/root/backups"

echo "Starting backup routine..."

# Get the current date
date=`date +%Y-%m-%d`

# Get a list of all databases
databases=`mysql -u $MYSQL_USERNAME -p $MYSQL_PASSWORD -e "SHOW DATABASES;" | tr -d "| " | grep -v Database`

# Make a backup of each database
for db in $databases; do
    if [[ "$db" != "information_schema" ]] && [[ "$db" != "performance_schema" ]] && [[ "$db" != "mysql" ]] && [[ "$db" != _* ]] ; then
        # Create a directory for the database
        mkdir -p $BACKUP_DIR/$db

        # Dump the database to a SQL file
        echo "Creating backup of $db"
        mysqldump -u $MYSQL_USERNAME -p$MYSQL_PASSWORD --databases $db > $BACKUP_DIR/$db/$db-$date.sql
    fi
done

echo "Backup routine complete!"
