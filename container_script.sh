#!/bin/bash

# Enable the sshd
systemctl enable ssh
service ssh start

# Add honeypot user
username=honeyuser
password=supersecretpass

adduser --gecos "" --disabled-password $username
chpasswd <<<"$username:$password"

# Run strace on the sshd program and output contents to capture
sshdpid=$(pgrep -l sshd | awk '{print $1;}')
strace -f -p $sshdpid -e trace=write -o capture
