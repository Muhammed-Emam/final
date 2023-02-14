#!/bin/bash
shopt -s extglob
export LC_COLLATE=C
SCRIPT_DIR=$( cd -- "$( dirname -- "$BASH_SOURCE" )" ; pwd;)

        read -p "Enter Your Database name: " database_name
		if [[ $database_name =~ ^[a-zA-Z]*$ ]]
		then 
				if [ -d "$SCRIPT_DIR"/databases/"$database_name" ]  
   				then 
                	ls "$SCRIPT_DIR"/databases/"$database_name"/
        		else
					echo "Sorry this database [$database_name]  doesn't exist "
				fi   
		else 
			echo "you should have entered a string"
		fi	