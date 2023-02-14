#!/bin/env bash
function connect_to_database() {
#jfjds
    source $SCRIPT_DIR/list_databases.sh
    flag=0
    while [ flag==0 ] ; do
        
        read -p "Enter database name: " database_name
            if [ -d "$SCRIPT_DIR"/databases/"$database_name" ]; then
                cd "$SCRIPT_DIR"/databases/"$database_name"
                echo "Connected to $database_name"
                echo "Tables are: "
                source "$SCRIPT_DIR"/table_options.sh
                flag= 1
            else
                echo "Error: database not found"
            fi

    done  
}

connect_to_database