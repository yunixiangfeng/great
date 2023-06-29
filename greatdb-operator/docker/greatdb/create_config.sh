#!/bin/bash
set -ex
ip=`echo $HOSTNAME`
echo "[mysqld]
datadir=/var/lib/greatdb-cluster/$1
socket=/var/lib/greatdb-cluster/$1/greatdb.sock
user=greatdb
port=$2
server_id=$2
max_connections=2000
report_host=127.0.0.1
skip_name_resolve=OFF

## group replication configuration
binlog-checksum=NONE
enforce-gtid-consistency
gtid-mode=ON
loose-group_replication_start_on_boot=OFF
loose_group_replication_recovery_get_public_key=ON
loose-group_replication_local_address= \"$ip:1$2\""
