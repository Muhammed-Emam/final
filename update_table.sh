#!/bin/bash
shopt -s extglob
export LC_COLLATE=C
read -p "enter your table to update : " tablename

if [ -e "$tablename" ]
then 
        z=`awk '{if(NR>3)print $0}' $tablename`
        pkCheck=`awk -F: '{if(NR==3){i=1; while(i<=NF){if($i=="pk"){print 1}i++}}}' $tablename`
      #   echo $pkCheck;
        echo "                  :Here is your table:                 "
        echo "           "
        echo "$z"
        echo "            ------------------              "
        echo "Choose the column in which you want to update"
        y=`awk -F: '{ if(NR<2){print $0}}' $tablename`
        echo "          :Your Columns will be:            "
        echo "$y"
        echo "    ------------------     "
      while true
      do
        read -p "Choose the Name of the column you want to SET ---> " colName
        colNameCheck=`awk -F: -v colName=$colName '{if(NR==1){for(i=1;i<=NF;i++){if($i==colName){print 1}}}}' $tablename`
           if [[ $colNameCheck -eq 1 ]]
           then
                  break;
           fi
            echo Please enter a valid Column Name
      done
      #   echo "$colNameCheck"

        if [[ $colNameCheck -eq 1 ]]
        then
        
            colNum=`awk -v colName=$colName 'BEGIN{ FS = ":" }{if(NR==1){i=1; while(i<=NF){if($i==colName){print i}i++}}}END{}' "$tablename" `

            lmeta=`awk -F: '{if(NR==2){for(i=1;i<=NF;i++){if(i=='$colNum'){print $'$colNum'}}}}' "$tablename"`
            echo "*********************"
            echo "Remember you should enter ----> [ ${lmeta[@]} ]"
            echo "*********************"
                          
            while [ true ]
            do
                read -p "And you would like to SET $colName =  ----> " updateWord
                if [ -z $updateWord ]
                then
                  check="error"
                 elif [[ $pkCheck == "1" && $colName == "id" ]]
                 then
                     check=`awk -F: -v updateWord=$updateWord '{if(NR>3){i=1; while(i<=NF){if(i==1){if($i==updateWord){print "error"}}i++}}}' $tablename`
                 fi
            if [[ $check != "error" ]]
            then
                  break;
            fi
            echo "Primary Key ERROR (Unique and Not NULL)"
            done
            while true
            do
                  read -p "where ----> " selectCol
                  selectColCheck=`awk -F: -v selectCol=$selectCol '{if(NR==1){for(i=1;i<=NF;i++){if($i==selectCol){print 1}}}}' $tablename`
                  if [[ $selectColCheck -eq 1 ]]
                  then
                        break;
                  fi
                   echo Please enter a valid Column Name
            done

            while true
            do
              read -p "where $selectCol = " selectedWord
              if ! [ -z $selectedWord ]
              then
                  break;
              fi
                  echo Please enter a valid data
            done
            selectedColNum=`awk -v selectCol=$selectCol 'BEGIN{ FS = ":" }{if(NR==1){i=1; while(i<=NF){if($i==selectCol){print i}i++}}}END{}' $tablename `
            recNum=(`awk -v selectedWord=$selectedWord -v selectedColNum=$selectedColNum 'BEGIN{ FS = ":";}{
                  i=1;
                  while(i<=NF){
                        if(i==selectedColNum){
                              if($i==selectedWord){ 
                                    print NR
                              }
                        }
                  i++;

                  }
            }END{}' "$tablename"`)
            # echo $recNum;
            if [[ $recNum -ne " " ]]
            then
                  selectword=`awk -F: -v recNum=$recNum -v colNum=$colNum '{
                        i=1;
                        if(NR==recNum){
                              
                              while(i<=NF){
                                    if(i==colNum){
                                          print $i
                                    }
                              i++
                              }
                        }
                  }' "$tablename" `
                  if [ $lmeta = "string" ]
                  then    
                        if  [[ "$updateWord" =~ ^[a-zA-Z]*$ ]]
                        then 
                              sed -i "$recNum s/$selectword/$updateWord/" $tablename 
                              e=`awk '{if(NR>3)print $0}' $tablename`
                              echo "  the table after update will be:  "
                              echo "$e"
                        else 
                              echo "sorry not correct" 
                        fi
                  else 
                        if [[ $updateWord =~ ^[0-9]*$ ]]
                        then    
                                    sed "$recNum s/$selectword/$updateWord/" $tablename > tempFile && mv tempFile $tablename
                                    wholeUpdatedTable=`awk '{if(NR>3)print $0}' $tablename`
                                    echo " Table $tablename after Update will be:  "
                                    echo "     "
                                    echo "$wholeUpdatedTable"    
                        else
                        echo "wrong you should have entered number"
                        fi
                  fi
            else
             echo No Record has been updated
            fi

      else 
            echo "Error, Column "$colName" does not exist in table "$tablename""
      fi
else
echo "ERROR, this file doesn't exist "
fi