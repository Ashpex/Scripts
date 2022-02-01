#!/bin/sh
systemctl start vmware-networks.service
systemctl start vmware-usbarbitrator.service
modprobe -a vmw_vmci vmmon
