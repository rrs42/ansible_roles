#!/bin/bash -x

serial=$(date +%Y%m%d%H%M)

ipa-server-install -N -U -p {{ipa_default_password}} -a {{ipa_default_password}} \
    -n {{ipa_domain}} -r {{ipa_realm}} \
    --ca-subject="CN=Certificate Authority, O={{ipa_realm}} ${serial}" \
    --idstart={{ipa_idstart}}
#   --hostname=idmserver.core-mem.net

echo {{ipa_default_password}} | kinit admin

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

ipa user-add steffenr \
    --first="Russ" \
    --last="Steffen" \
    --initials="RS" \
    --gecos="Russ Steffen" \
    --homedir=/home/steffenr \
    --uid=10000 \
    --shell=/bin/bash \
    --sshpubkey='{{ lookup( 'file', '../n62key.pub') }}'

ipa sudorule-add rootme --hostcat=all --cmdcat=all --runasusercat=all
ipa sudorule-add-user rootme --users=steffenr
ipa sudorule-add-option rootme --sudooption='!authenticate'
