# IBM Kali Linux Hardening & Secure Lab Setup

## 📖 Project Overview
As part of the **IBM Ethical Hacking with Open Source Tools Professional Certificate**, this project documents the foundational hardening of a Kali Linux virtual machine. The objective is to reduce the system's attack surface and establish a secure, isolated environment for ethical hacking and penetration testing activities.

## 🎯 Objectives Achieved
- Deployed a Kali Linux VM using Oracle VirtualBox with isolated networking.
- Patched the OS and applications to mitigate known CVEs.
- Enforced strong Identity and Access Management (IAM) by changing default credentials and implementing Role-Based Access Control (RBAC).
- Automated user provisioning using a custom Bash script to ensure consistency and reduce human error.

## 🛠️ Environment & Tools
- **Hypervisor:** Oracle VirtualBox 7.x
- **Guest OS:** Kali Linux (Debian-based)
- **Scripting:** Bash
- **Tools:** `apt`, `useradd`, `passwd`, `openssl`

## 🚀 Execution Methodology

### 1. System Patching
```bash
sudo apt update && sudo apt full-upgrade -y