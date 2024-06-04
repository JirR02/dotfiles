#!/bin/bash

sketchybar --add item battery right \
           --set battery update-freq=120 \
                          script="$PLUGIN_DIR/battery.sh" \
           --subscribe battery system_woke power_source_change
