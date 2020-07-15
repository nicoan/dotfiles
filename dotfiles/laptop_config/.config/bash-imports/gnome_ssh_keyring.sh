#!/bin/bash
# Gnome keyring setup for SSH
eval $(gnome-keyring-daemon --start)
export SSH_AUTH_SOCK
