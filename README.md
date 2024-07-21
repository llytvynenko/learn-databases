## [About](#about)

This repository provides a way to quickly run queries against 4 major SQL database engines for the learning purposes:
 - Postgres
 - MS SQL
 - MySql
 - Sqlite

***

It is intentionally designed as a single docker image, to be as lightweight, easy to use, and zero-configurable as possible.  

For a more complete docker compose solution, please refer to https://github.com/luisaveiro/localhost-databases which was used as an inspiration.

***

Databases are configured to persist data between the runs in the docker volumes (see `run.sh`). If your usecase reguires ememeral

## [Installation](#installation)

To use the repository, first you need to build a docker image
```sh
docker build -t learn-databases .
```

Ensure the execution persmissions are granted for the script
```sh
chmod +x run.sh
```

Then run the database selection script:
```sh
./run.sh
```

## [Usage](#usage)

Script prompts a database engine:
```txt
Choose the database to connect to:
1) PostgreSQL
2) MSSQL
3) MySQL
4) SQLite3
Enter the number: 4
```

and then runs a corresponding interactive sql session
```sql
sqlite> select * from names;
1|hello
2|world
sqlite> .quit
```
