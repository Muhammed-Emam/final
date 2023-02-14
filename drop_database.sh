function drop_database() {
  source ./list_databases
  read -p "Enter database name: " database_name
  if [ -d "$database_name" ]; then
    rm -rf "$database_name"
    echo "Database $database_name dropped successfully"
  else
    echo "Error: database not found"
  fi
}

drop_database













