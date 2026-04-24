#!/usr/bin/env fish

# Stagger non-interactive tasks so the session becomes usable as quickly as possible.

sleep 3
/usr/lib/geoclue-2.0/demos/agent >/dev/null 2>&1 &

sleep 1
gammastep >/dev/null 2>&1 &

command -sq nemo-desktop; and nemo-desktop >/dev/null 2>&1 &

sleep 1
mpris-proxy >/dev/null 2>&1 &

sleep 15
trash-empty 30 >/dev/null 2>&1
