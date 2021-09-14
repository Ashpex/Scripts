#!/bin/sh
systemctl start vmware-networks.service
modprobe -a vmw_vmci vmmon
