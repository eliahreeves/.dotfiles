#!/bin/bash
# cp low_bat_check.sh /usr/local/bin/
cp 99-lowbat.rules /etc/udev/rules.d/
udevadm control --reload
