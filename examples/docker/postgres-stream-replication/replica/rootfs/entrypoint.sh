#!/bin/bash
envs() {
    echo "##################################################################"
    echo ""
    echo "PGDATA: $PGDATA"
    echo "POSTGRES_REPLICATION_USER: $POSTGRES_REPLICATION_USER"
    echo "POSTGRES_REPLICATION_PRIMARY_HOST: $POSTGRES_REPLICATION_PRIMARY_HOST"
    echo "POSTGRES_REPLICATION_PRIMARY_PORT: $POSTGRES_REPLICATION_PRIMARY_PORT"
    echo ""
    echo "##################################################################"
}

envs

if [ ! -s "$PGDATA/PG_VERSION" ]; then
echo "*:*:*:$POSTGRES_REPLICATION_USER:$POSTGRES_REPLICATION_PASSWORD" > ~/.pgpass
chmod 0600 ~/.pgpass
until ping -c 1 -W 1 $POSTGRES_REPLICATION_PRIMARY_HOST
do
echo "Waiting for master to ping..."
sleep 1s
done
echo "PostgreSQL:  Streaming Replication....[Replica]....."
until pg_basebackup -h $POSTGRES_REPLICATION_PRIMARY_HOST -U $POSTGRES_REPLICATION_USER -p $POSTGRES_REPLICATION_PRIMARY_PORT -D $PGDATA -P -Xs -R
cat $PGDATA/recovery.conf
do
echo "Waiting for master to connect..."
sleep 1s
done
set -e
chown postgres. ${PGDATA} -R
chmod 700 ${PGDATA} -R
fi
exec "$@"