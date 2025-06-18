#!/bin/bash

# Update system packages
yum update -y

# Enable and configure firewall (Amazon Linux uses firewalld)
yum install -y firewalld
systemctl enable firewalld
systemctl start firewalld
firewall-cmd --permanent --zone=public --add-port=22/tcp
firewall-cmd --reload

# Disable root SSH login
sed -i 's/^PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config

# Enforce key-based authentication
sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
systemctl restart sshd

# Install fail2ban
amazon-linux-extras enable epel
yum install -y fail2ban
systemctl enable fail2ban
systemctl start fail2ban
