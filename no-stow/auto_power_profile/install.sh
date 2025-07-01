#!/bin/bash

cp power_mode_76.sh /usr/local/bin/
cp 99-power-mode.rules /etc/udev/rules.d/
cp power-mode-on-start.service /etc/systemd/system/
systemctl daemon-reload
systemctl enable --now power-mode-on-start.service
udevadm control --reload
