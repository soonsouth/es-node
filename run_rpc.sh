#!/bin/sh

# usage:
# ./run_rpc.sh

executable="./cmd/es-node/es-node"
data_dir="./es-data"
storage_file_0="$data_dir/shard-0.dat"

common_flags=" --datadir $data_dir \
  --encoding_type 0 \
  --l1.rpc http://65.108.236.27:8545 \
  --storage.l1contract 0x9f9F5Fd89ad648f2C000C954d8d9C87743243eC5"

# init shard 0
es_node_init="init --shard_index 0"

# start node 
# TODO remove --network
es_node_start=" --network devnet \
  --storage.files $storage_file_0 \
  --l1.beacon http://65.108.236.27:5052 \
  --l1.beacon-based-time 1698751812 \
  --l1.beacon-based-slot 1 \
  --p2p.listen.udp 30305 \
  --p2p.bootnodes enr:-Li4QBn86W_viHlm3Fy-8EIukaE5ZbUxjd0be155AcDh5ZqMYPpgHXiWiUWFY9U63Xvqh52NBs16zOomxWHOZklMiueGAYuKhdVnimV0aHN0b3JhZ2XbAYDY15Sfn1_YmtZI8sAAyVTY2ch3QyQ-xcGAgmlkgnY0gmlwhEFtP5qJc2VjcDI1NmsxoQM1dy9sMGU3CnBv9b0qNjyRvfNBbgE-rJXFS2lfXJ8T1IN0Y3CCJAaDdWRwgnZh \
"
# create data file for shard 0 if not yet
if [ ! -e $storage_file_0 ]; then
  $executable $es_node_init $common_flags
  echo "initialized ${storage_file_0}"
fi

# start es-node
exec $executable $es_node_start $common_flags
