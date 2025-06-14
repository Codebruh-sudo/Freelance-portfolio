#!/bin/bash

# Update system
echo "Updating packages..."
sudo apt update && sudo apt upgrade -y

# Install Lynis
echo "Installing Lynis..."
sudo apt install lynis -y

# Run initial security audit
echo "Running Lynis audit..."
sudo lynis audit system | tee lynis-report.txt

# Install UFW (firewall)
echo "Setting up UFW..."
sudo apt install ufw -y
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh     # Allow SSH
sudo ufw enable

# Harden SSH settings
echo "Hardening SSH..."
sudo sed -i 's/^#Port 22/Port 2222/' /etc/ssh/sshd_config     # Change SSH port
sudo sed -i 's/^#PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo systemctl restart sshd

# Install Fail2Ban
echo "Installing Fail2Ban..."
sudo apt install fail2ban -y

# Basic Fail2Ban jail configuration
echo "Configuring Fail2Ban..."
sudo bash -c 'cat > /etc/fail2ban/jail.d/defaults-debian.conf <<EOF
[sshd]
enabled = true
port = 2222
filter = sshd
logpath = /var/log/auth.log
maxretry = 5
EOF'

sudo systemctl restart fail2ban

echo "Hardening complete. Check lynis-report.txt for detailed audit results."
