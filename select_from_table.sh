#!/bin/bash
shopt -s extglob
export LC_COLLATE=C
# cd $PWD/Database
# read -p "Enter the name of databse: " databaseName
# echo "                                             "

# if [[ "$databaseName" =~ ^[a-zA-Z]*$ ]]
# then 
#      if  [ -e "$databaseName" ]
 
#     then 
#             cd $databaseName

            read -p "Enter the name of your table: " tableName
            echo "                                             "
            if [[ "$tableName" =~ ^[a-zA-Z.]*$ ]]

            then     if [ -f "$tableName" ]
                     then 
                                PS3="Enter your Choice ----> "

                        
                                select choice in select_all select_by_col select_by_row Exit
		                        do
		                        case $choice in 	
		                                select_all)  
			                            awk '{if(NR>3)print $0}' $tableName
                                                ;;
		                                select_by_col)

                                            NumberofFields=`awk -F: '{print NF}' $tableName | head -1`
                                            echo "number field = $NumberofFields"
                                            awk '{if(NR<2)print $0}' "$tableName"
                                            read -p "Here is your columns, please choose the number of column that you want: " colNumber
                                            echo "      ---------------     " 

                                            if [[ $colNumber -gt $NumberofFields ]]
                                            then 
                                                echo " ERROR, your [ $colNumber ] doesn't exist in the table "
                                            else
                                                
                                                echo "---> Column number [ $colNumber ] will be:  "
                                                awk -F: '{if(NR>3)print $'$colNumber'}' "$tableName"
                                            fi
			                                ;;

		                                select_by_row)
                                                    read -p "Enter the Id by which you want to select -->  " idNo
                                                    if [[ $idNo -ne " " ]]
                                                    then
                                                    Allids=(`awk -F: '{if(NR>3)print $1}' $tableName`)
                                                    flag=0
                                                    for element in ${Allids[@]}
                                                    do
                                                        if [ $idNo == $element ]
                                                        then
                                                            awk -F: -v idNo=$idNo '{if(NR>3){if(idNo==$1)print $0}}' $tableName
                                                            flag=1
                                                           # echo "Your row will be ---> [$selRow]"
                                                        fi
                                                    done
                                                        if (( $flag == 0 ))
                                                        then
                                                            echo "Error id is not uniqe" 
                                                        fi
                                                    else 
                                                        echo id not valid
                                                    fi
                                                    ;;


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


