function insert_into_table() {
  read -p "Enter table name: " table_name
  if [ -f "$table_name.csv" ]; then
    
    
    #IFS=':' read -r -a columns <<< "${columns_datatype_pk[0]}"
    #IFS=':' read -r -a datatype <<< "${columns_datatype_pk[1]}"
    #IFS=':' read -r -a pk <<< "${columns_datatype_pk[2]}"
    
    columns_datatype_pk=($(head -n 3 "$table_name.csv"))
    columns=($(echo "${columns_datatype_pk[0]}" | tr ':' '\n'))
    datatype=($(echo "${columns_datatype_pk[1]}" | tr ':' '\n'))
    pk=($(echo "${columns_datatype_pk[2]}" | tr ':' '\n'))

    values=""
    for i in "${!columns[@]}"; do
      value=""
      while [ -z "$value" ]; do
        read -r -p "Enter value for ${columns[$i]} (${datatype[$i]}): " value
        # Check if the value is of the correct datatype
        if [ "${datatype[$i]}" == "int" ]; then
          if [[ ! "$value" =~ ^[0-9]+$ ]]; then
            echo "Error: invalid input, ${columns[$i]} should be of type ${datatype[$i]}"
            value=""
            continue
          fi
        elif [ "${datatype[$i]}" == "string" ]; then
          if [[ ! "$value" =~ ^[a-zA-Z\ ]+$ ]]; then
            echo "Error: invalid input, ${columns[$i]} should be of type ${datatype[$i]}"
            value=""
            continue
          fi
        fi
        # Check if the value is unique for primary keys
        if [ "${pk[$i]}" == "pk" ]; then
          flag_found=false
          echo "$flag_found before loop"

          output=$(awk -F":" 'NR==4, NR==$NR {print $((i+1))}' "$table_name.csv")
          #echo "Output: ${output[@]}"
          for element in ${output[@]}; do
            #echo "Checking: $element against $value"
            if [[ $value == $element ]] ; then
              flag_found=true
              break
            fi

          done  

          if [ $flag_found == true ]; then
            echo "Error: value for primary key ${columns[$i]} should be unique"
            value=""
            continue
          fi
        fi
      done
      values="$values:$value"
    done
    values="${values:1}"
    echo "$values"

    temp_file=$(mktemp)
    echo "$values" > "$temp_file"
    cat "$temp_file" >> "$table_name.csv"

    echo "Row inserted into $table_name successfully"
  else
    echo "Error: table $table_name not found"
  fi
}

insert_into_table
