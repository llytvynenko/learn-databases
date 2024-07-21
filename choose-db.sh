#!/bin/bash

# Initialize PostgreSQL data directory if not already initialized
if [ ! -d "/var/lib/postgresql/data" ]; then
  sudo -u postgres /usr/lib/postgresql/12/bin/initdb -D /var/lib/postgresql/data
fi

echo "Choose the database to connect to:"
echo "1) PostgreSQL"
echo "2) MSSQL"
echo "3) MySQL"
echo "4) SQLite3"
read -p "Enter the number: " db_choice

case $db_choice in
  1)
    service postgresql start
    PGPASSWORD="password" psql -U postgres -d postgres -h localhost
    ;;
  2)
    export ACCEPT_EULA=Y
    export MSSQL_SA_PASSWORD="yourStrong(!)Password"
    /opt/mssql/bin/sqlservr & 
    sleep 20  # wait for MSSQL server to start
    sqlcmd -S localhost -U sa -P "yourStrong(!)Password"
    ;;
  3)
    service mysql start
    mysql -u root -ppassword -h localhost
    ;;
  4)
    default_sqlite_db="/data/mydatabase.db"
    if [ ! -f "$default_sqlite_db" ]; then
      touch "$default_sqlite_db"
    fi
    sqlite3 $default_sqlite_db
    ;;
  *)
    echo "Invalid choice"
    ;;
esac