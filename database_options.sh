#!/bin/env bash
#script_dir=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)
SCRIPT_DIR=$( cd -- "$( dirname -- "$BASH_SOURCE" )" ; pwd;)
#shopt -s extglob
#export LC_COLLATE=C
#sed -i 's/\r//g' ./entry.sh

options=( "Create Database" "List Databases" "Connect To Databases" "Drop Database" "Exit" )
# echo ${options[*]}

cd $SCRIPT_DIR
if [ -d "$SCRIPT_DIR/databases" ]; then
    cd "$SCRIPT_DIR"/databases

  else
    mkdir "$SCRIPT_DIR/databases"
    cd "$SCRIPT_DIR"/databases
fi


while true; do
    echo "Main Menu"
    
PS3=' Choose an option : '

    select choice in "${options[@]}"; 
    do
      
      case $choice in
        "Create Database")  source $SCRIPT_DIR/create_database.sh ;;
        "List Databases")  source $SCRIPT_DIR/list_databases.sh ;;
        "Connect To Databases") source $SCRIPT_DIR/connect_database.sh ;;
        "Drop Database") source .$SCRIPT_DIR/drop_database.sh ;;
        "Exit") break ;;
         *) echo "Invalid choice, try again" ;;
      esac
    done
done




