FROM ubuntu:20.04

# Set environment variables for non-interactive installs
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies and add Microsoft repository for MSSQL
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    software-properties-common \
    wget \
    gnupg2 \
    curl \
    sudo \
    postgresql \
    postgresql-client \
    mysql-server \
    mysql-client \
    sqlite3 \
    unixodbc-dev \
    && curl -sSL https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl -sSL https://packages.microsoft.com/config/ubuntu/20.04/prod.list | tee /etc/apt/sources.list.d/msprod.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y mssql-tools

# Install mssql-server separately due to repo issues
RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/20.04/mssql-server-2019.list)" \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y mssql-server

# Add MSSQL tools to PATH
ENV PATH="$PATH:/opt/mssql-tools/bin"

# Initialize PostgreSQL and MySQL
RUN service postgresql start && \
    service mysql start && \
    su - postgres -c "psql -c \"ALTER USER postgres PASSWORD 'password';\"" && \
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'password'; FLUSH PRIVILEGES;"

# Copy the script
COPY choose-db.sh /usr/local/bin/choose-db.sh
RUN chmod +x /usr/local/bin/choose-db.sh

# Set the entry point to the script
ENTRYPOINT ["/usr/local/bin/choose-db.sh"]