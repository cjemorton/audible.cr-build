#!/usr/bin/env bash

aria2c --dry-run -c `./link -a B07PGW6Y21 -c LC_64_22050_Stereo` | grep 'OK' | cut -d'|' -f 4 | head -n 1 | rev | cut -d'/' -f 1 |cut -d'.' -f 2 | rev
