#!/bin/bash -x

serial=$(date +%Y%m%d%H%M)

ipa-server-install -N -U -p 1qazxsw2 -a 1qazxsw2 \
    -n core-mem.net -r CORE-MEM.NET \
    --ca-subject="CN=Certificate Authority, O=CORE-MEM.NET ${serial}" \
    --idstart=2000 \
    --hostname=idmserver.core-mem.net

echo 1qazxsw2 | kinit admin

ipa config-mod --defaultshell=/bin/bash

ipa user-add kafka \
    --first="Kafka" \
    --last="User" \
    --initials="" \
    --gecos="Kafka service account" \
    --displayname="Kafka service account" \
    --homedir=/opt/kafka \
    --shell=/bin/bash \
    --random \
    --uid=1500 \
    --gidnumber=1500

ipa user-add nifi \
    --first="NiFi" \
    --last="User" \
    --initials="" \
    --gecos="NiFi service accounr" \
    --displayname="NiFi service account" \
    --homedir=/opt/nifi \
    --shell=/bin/bash \
    --random \
    --uid=1501 \
    --gidnumber=1501

ipa automountlocation-add cluster
ipa automountmap-add cluster auto.home
ipa automountkey-add cluster auto.home --key="*" --info="-fstype=nfs4 10.80.0.232:/srv/exports/home/&"
ipa automountkey-add cluster auto.master --key="/home" --info="auto.home"
ipa automountkey-add cluster auto.direct --key="/site" --info="-fstype=nfs4 10.80.0.232:/srv/exports/site"
