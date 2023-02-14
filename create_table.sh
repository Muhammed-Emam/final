function create_table() {
  SCRIPT_DIR=$( cd -- "$( dirname -- "$BASH_SOURCE" )" ; pwd;)
  
  local flag="false"
  
  while [ "$flag" == "false" ]; do
    read -p "Enter table name: " table_name
    if [[ "$table_name" =~ ^[a-zA-Z0-9_-]+$ ]]; then
      if [ -f "$table_name.csv" ]; then
        echo "Error: table already exists"
      else
        read -p "Enter columns (column1:datatype:pk, column2:datatype:pk, ...): " columns

        IFS=', ' read -r -a columns_array <<< "$columns"


        values=""
        datatypes=""
        pks=""
        for i in "${columns_array[@]}" ; do
        value=$(echo "$i" | cut -d: -f1)
        datatype=$(echo "$i" | cut -d: -f2)
        pk=$(echo "$i" | cut -d: -f3)
        values="$values:$value"
        datatypes="$datatypes:$datatype"
        pks="$pks:$pk"
        done
        values=${values:1}
        datatypes=${datatypes:1}
        pks=${pks:1}
        echo "$values" >> "$table_name.csv"
        echo "$datatypes" >> "$table_name.csv"
        echo "$pks" >> "$table_name.csv"
        flag="true"
      fi
      source "$SCRIPT_DIR"/table_options.sh
    else
      echo "Error: invalid table name, table name can only contain letters, numbers, underscores, and hyphens"
    fi
  done
}
create_table















