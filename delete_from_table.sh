#!/bin/bash
shopt -s extglob
export LC_COLLATE=C

# read -p "Enter the name of database: " databaseName
# echo "                                             "
# if [[ "$databaseName" =~ ^[a-zA-Z]*$ ]]
# then 
    #  if  [ -e "$databaseName" ]
 
    # then 
            # cd $databaseName

            read -p "Enter the name of your table: " tableName
            echo "                                             "
            if [[ "$tableName" =~ ^[a-zA-Z.]*$ ]]

            then     if [ -f "$tableName" ]
                     then 
                                PS3="Enter your Choice ----> "

                                select choice in delete_all delete_by_row Exit
		                        do
		                        case $choice in 	
		                                delete_all)
                                                
			                                    sed -i '4,$d' $tablename
							                    if [ $?==0 ]
							                    then 
								                echo "Your data has been successfully deleted "
							                    fi
                                                echo "------------------------------"
                                                ;;
		                      
		                                delete_by_row)

                                            totalIds=(`awk -F: '{if(NR>3)print $1}' $tableName`)
                                             totalLines=`wc -l $tableName`
                                            # echo "$totalLines"
                                             tableLines=$totalLines-3
                                            # echo "$tableLines"
                                            # echo "${totalIds[@]}"
                                            read -p "Choose the ID that you would like to delete : " reqID
                                            fl=0
                                            for element in ${totalIds[@]}
                                            do
                                                    # echo "$reqID" 
                                                    # echo "$element"
                                                if [ $reqID == $element ]
                                                then
                                                    
                                                    
                                                    recordNumber=`awk -F: -v reqID=$reqID -v reqNum=0 '{if(NR>3)for(i=1;i<=NF;i++){if($1==reqID)  reqNum=NR}}END{print reqNum}' $tableName`
                                                   # echo "$recordNumber"
                 
                                                   
                                                    fl=1
                                                    sed -i "${recordNumber}d" $tableName

                                                    if [ $?==0 ]
                                                    then 
                                                    echo "The ID number [ $reqID ] has been successfully deleted "
                                                    fi
                                                fi
                                            done

                                            if [[ fl -eq 0 ]]
                                            then echo "The ID of $reqID is not found on the table"
                                            fi 
                                          break;;
                                        Exit) 
                                            break;;
                                esac
                                done
                    else 
                        echo "This table is not found"
                    fi
            else 
                echo "please enter the table name in string"
            fi
#     else
#         echo "The database is not found"
    
#     fi
# else
#     echo "This database should be String"
# fi