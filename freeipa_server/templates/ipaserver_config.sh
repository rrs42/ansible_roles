#!/bin/bash -x

serial=$(date +%Y%m%d%H%M)

ipa-server-install -N -U -p 1qazxsw2 -a 1qazxsw2 \
    -n core-mem.net -r CORE-MEM.NET \
    --ca-subject="CN=Certificate Authority, O=CORE-MEM.NET ${serial}" \
    --idstart=10000 \
    --hostname=idmserver.core-mem.net

echo 1qazxsw2 | kinit admin

ipa automountlocation-add cluster
ipa automountmap-add cluster auto.home
ipa automountkey-add cluster auto.home --key="*" --info="-fstype=bind :/gpfs/fs1/home/&"
ipa automountkey-add cluster auto.master --key="/home" --info="auto.home"
