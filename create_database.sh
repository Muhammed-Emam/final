#!/bin/env bash
# PS3='Choose an option '$PWD': '

#SCRIPT_DIR=$( cd -- "( dirname -- "$BASH_SOURCE" )" ; pwd;)
echo "$SCRIPT_DIR"



shopt -s extglob
export LC_COLLATE=C
#sed -i 's/\r//g' ./create_database.sh

 # cd databases

create_database() {
    flag=0
    while [ flag==0 ] ; do
      read -p "Enter database name: " database_name
      if [ -d "$database_name" ]; then
        echo "Error: database already exists"
      else
        mkdir "$SCRIPT_DIR"/databases/"$database_name"
        echo "Database $database_name created successfully"
        flag=1
      fi
      source $SCRIPT_DIR/database_options.sh
    done



}

create_database