# Ansible Roles

1. **epel**
    * installs the epel-release RPM package

1. genders_file
    * build /etc/genders
    * TODO: formalize specifying other genders besides all

1. gpfs
    * installs gpfs repo
    * installs gpfs packages
    * depends: *cluster_ssh*
    * TODO: Formalize gpfs repo host url

1. gpfs_gui
    * installs GPFS gui

1. gpfs_pmcollector
    * installs GPFS pm_collector package

1. gpfs_pmsensor
    * installs GPFS pm_sensor package

1. gpfs_protocol
    * installs GPFS protocol support packages
    * TODO: very beta right now

1. gpfs_snmp
    * installs snmpd config file w/ GPFS SNMP collector support

1. grafana
    * installs grafana
    * depends: *grafana_repo*

1. grafana_repo
    * installs grafana RPM repo

1. hosts
    * adds a list of hosts, IPs to /etc/hosts
    * TODO: Formalize parameters, hostlist

1. influxdb
1. influx_repo
    * Installs the InfluxDB yum repository

1. local_repo
    * installs a yum repo hosted on local system
    * TODO: formalize repo host parameter

1. yum_proxy
    * sets yum proxy
    * adds proxy host to /etc/hosts
    * TODO: formalize proxy host parameter, verify idempotency
    * TODO: revert proxy settings when yum_proxy flag is false

1. pdsh
    * install pdsh packages

1. runlevel
    * sets the system to start the Xserver on boot

1. snmp_host
    * installs snmpd packages, optional default config file
    * TODO: set more snmpd config items as facts for other modules or take more parameters

1. telegraf
    * installs telegraf packages
    * depends: *influx_repo*

1. update
    * updates all packages

# Roles not yet promoted
1. cluster_ssh
    * sets up mutual ssh trust on all hosts
    * passwordless root shell access
    * TODO: revamp host list, key spec

# Roles still needed

* collectd
* pcp
