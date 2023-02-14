#!/bin/env bash
shopt -s extglob
export LC_COLLATE=C
#sed -i 's/\r//g' ./entry.sh

SCRIPT_DIR=$( cd -- "$( dirname -- "$BASH_SOURCE" )" ; pwd;)
options=( "Create Table" "List Tables" "Drop Table" "Insert into table" "Select from Table" "Delete from table" "Update Table" "Main Menu")
# echo ${options[*]}
PS3='Choose an option: '
while true; do
    echo "Menu"
    
    select choice in "${options[@]}"; 
    do
      case $choice in
        "Create Table")  source $SCRIPT_DIR/create_table.sh ;;
        "List Tables")  source $SCRIPT_DIR/list_tables.sh ;;
        "Drop Table") source $SCRIPT_DIR/drop_table.sh ;;
        "Insert into table") source $SCRIPT_DIR/insert_into_table.sh ;;
        "Select from Table") source $SCRIPT_DIR/select_from_table.sh ;;
        "Delete from table") source $SCRIPT_DIR/delete_from_table.sh ;;
        "Update Table") source $SCRIPT_DIR/update_table.sh ;;
        "Main Menu") source $SCRIPT_DIR/database_options.sh ;;
        *) echo "Invalid choice, try again" ;;
      esac
    done
done