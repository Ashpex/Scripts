#!/usr/bin/env bash

sudo systemctl start bluetooth.service
bluetoothctl power on
bluetoothctl
