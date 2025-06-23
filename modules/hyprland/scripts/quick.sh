#!/bin/sh

active=$(hyprctl activeworkspace | head -n 1 | awk '{print $3}')
special="quick-${active}"
hyprctl dispatch togglespecialworkspace $special
