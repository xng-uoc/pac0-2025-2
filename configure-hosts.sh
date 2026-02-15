#!/bin/sh

clab_name="pac0-2025-2"

# Remove the default routes to ensure that routers and hosts are isolated
printf "Removing default routes from routers and hosts..."
sudo docker exec -d clab-$clab_name-vyos01 ip route del default via 172.20.20.1
sudo docker exec -d clab-$clab_name-vyos02 ip route del default via 172.20.20.1
sudo docker exec -d clab-$clab_name-vyos03 ip route del default via 172.20.20.1
sudo docker exec -d clab-$clab_name-host01 ip route del default via 172.20.20.1
sudo docker exec -d clab-$clab_name-host02 ip route del default via 172.20.20.1
sudo docker exec -d clab-$clab_name-host03 ip route del default via 172.20.20.1
printf " done!\n"
