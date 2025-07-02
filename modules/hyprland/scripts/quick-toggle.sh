#!/bin/sh

active=$(hyprctl activeworkspace -j | jq ".id")
special="quick-${active}"
hyprctl dispatch togglespecialworkspace $special
