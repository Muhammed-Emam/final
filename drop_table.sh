#!/bin/bash
shopt -s extglob
export LC_COLLATE=C
SCRIPT_DIR=$( cd -- "$( dirname -- "$BASH_SOURCE" )" ; pwd;)

read -p "Enter Your Database name:  " database_name
if [[ $database_name =~ ^[a-zA-Z]*$ ]] 
then
          
        if [ -d "$SCRIPT_DIR"/databases/"$database_name" ]
		then 
              
				read -p "Enter the name of the table you want to drop :  " table_name
	
				if [[ "$table_name" =~ ^[a-zA-Z.]*$ ]]
				then 
						if [ -f $table_name ]
						then 
				      		rm $table_name
					  		echo "Your table [$table_name] has been successfully dropped"
						else
							echo "***ERROR, your table [$table_name] doesn't exist***"
						fi
	    		else
					echo "***ERROR, enter a string for the table name***" 
				fi        
	             
		        
		        
		else 
			echo "***This database [$database_name] doesn't exist***"
		fi		
else
      echo "***ERROR, please enter a string for the database name***"
fi	