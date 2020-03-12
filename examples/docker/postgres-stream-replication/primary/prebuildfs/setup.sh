#!/bin/bash
echo "##################################################################"
echo ""
echo "PGDATA: $PGDATA"
echo "POSTGRES_USER: $POSTGRES_USER"
echo "POSTGRES_DB: $POSTGRES_DB"
echo "POSTGRES_REPLICATION_USER: $POSTGRES_REPLICATION_USER"
echo "POSTGRES_REPLICATION_LOGIN_CONNECTION_LIMIT: $POSTGRES_REPLICATION_LOGIN_CONNECTION_LIMIT"
echo ""
echo "##################################################################"
echo "host replication $POSTGRES_REPLICATION_USER 0.0.0.0/0 md5" >> "$PGDATA/pg_hba.conf"
set -e
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
CREATE USER $POSTGRES_REPLICATION_USER REPLICATION LOGIN CONNECTION LIMIT $POSTGRES_REPLICATION_LOGIN_CONNECTION_LIMIT ENCRYPTED PASSWORD '$POSTGRES_REPLICATION_PASSWORD';
EOSQL
cat >> ${PGDATA}/postgresql.conf <<EOF
wal_level = hot_standby
archive_mode = on
archive_command = 'cd .'
max_wal_senders = 8
wal_keep_segments = 8
hot_standby = on
EOF