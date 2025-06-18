# 🚀 DevOps & AWS Automation Projects

This repository contains a collection of practical DevOps and AWS projects I've built to gain real-world experience with infrastructure automation, monitoring, security, and cloud provisioning.

---

## 📌 Projects Overview

### 1️⃣ Prometheus + Grafana Container Monitoring
- **What it does:** Sets up Prometheus and Grafana using Docker Compose to monitor system and container metrics in real time.
- **Features:** Node Exporter, cAdvisor integration, custom Prometheus config, pre-built dashboards.
- **Path:** `./prometheus-grafana-monitoring/`

### 2️⃣ Launch EC2 Instance with Terraform
- **What it does:** Uses Terraform to provision and secure an AWS EC2 instance with firewall rules and key-based access.
- **Features:** Modular Terraform code, auto bootstrapping with user data, SSH hardening.
- **Path:** `./ec2-terraform-setup/`

### 3️⃣ Linux Server Hardening Script
- **What it does:** Applies basic Linux security best practices to reduce common vulnerabilities.
- **Features:** Disables root login, enforces SSH key auth, configures firewalld, installs Fail2Ban.
- **Path:** `./linux-hardening-script/`

### 4️⃣ EC2 Provisioning with AWS CLI
- **What it does:** Launches and configures EC2 instances using AWS CLI commands and shell scripts.
- **Features:** Auto tag instances, security group setup, key pair management, instance monitoring setup.
- **Path:** `./ec2-cli-setup/`

### 5️⃣ CI/CD Pipeline Monitoring Setup *(Optional if included)*
- If you've also included a pipeline project, we can add it here!

---

## 🛠 Technologies Used
- AWS (EC2, CLI, IAM, Security Groups)
- Terraform
- Docker & Docker Compose
- Prometheus + Grafana
- Linux (CentOS/Ubuntu), SSH, systemd
- Bash scripting

---

## 📥 Getting Started

Each project has its own directory with setup instructions and configuration files. To get started:
```bash
cd <project-folder>
