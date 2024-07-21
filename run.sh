docker run -it --rm \
  -v postgresql_data:/var/lib/postgresql \
  -v mssql_data:/var/opt/mssql \
  -v mysql_data:/var/lib/mysql \
  -v sqlite_data:/data \
  learn-databases