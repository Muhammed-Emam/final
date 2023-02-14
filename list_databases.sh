#!/bin/env bash

#SCRIPT_DIR=$( cd -- "$( dirname -- "$BASH_SOURCE" )" ; pwd;)
function list_databases() {
  
  echo "Databases:"
  
  ls -F $SCRIPT_DIR/databases | grep /
}

list_databases