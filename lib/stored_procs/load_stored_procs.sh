#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Usage: `basename $0` psql_login"
  exit 1
fi

for arg in `ls *.sql`
do
  psql -U $1 -f $arg
done
