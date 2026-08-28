# Kali Linux System Hardening Lab

![Kali Linux](https://img.shields.io/badge/OS-Kali%20Linux-557C94?logo=kalilinux\&logoColor=white)
![Shell](https://img.shields.io/badge/Shell-Bash-4EAA25?logo=gnu-bash\&logoColor=white)
![Security](https://img.shields.io/badge/Focus-System%20Hardening-red)
![UFW](https://img.shields.io/badge/Firewall-UFW-orange)

## 📌 Project Overview

This project documents a practical **Linux System Hardening** lab performed on Kali Linux.

The objective was to apply fundamental security controls that reduce common attack surfaces, including:

* Keeping the operating system up to date
* Securing user credentials
* Applying the Principle of Least Privilege
* Managing users and groups
* Configuring host-based firewall rules
* Restricting unnecessary network services
* Automating secure user provisioning with Bash

The project combines the manual system-hardening exercises from the lab with an additional Bash automation script designed to demonstrate how repetitive administrative security tasks can be automated.

---

## 🎯 Objectives

The main objectives of this project were to:

1. Update the Kali Linux operating system.
2. Remediate default or weak credentials.
3. Create standard user accounts.
4. Organize users through security groups.
5. Apply the Principle of Least Privilege.
6. Configure UFW as a host-based firewall.
7. Restrict insecure services such as Telnet.
8. Maintain secure remote administration through SSH.
9. Automate user provisioning using Bash.
10. Verify the implemented security controls.

---

## 🖥️ Environment

| Component           | Configuration              |
| ------------------- | -------------------------- |
| Operating System    | Kali Linux                 |
| Shell               | Bash                       |
| Firewall            | UFW                        |
| User Management     | Linux users/groups         |
| Automation          | Bash + OpenSSL             |
| Testing Environment | Kali Linux lab environment |

> **Note:** Commands and firewall rules should be adapted to the actual lab environment and services running on the system.

---

# 🔐 System Hardening Process

## Phase 1 — System Updates

The first step was to update the operating system and installed packages.

```bash
sudo apt update
sudo apt full-upgrade -y
```

### Security Justification

Keeping the operating system and installed packages updated helps reduce exposure to publicly known vulnerabilities and security defects.

A hardened system should not rely solely on configuration controls; maintaining current security patches is also an essential part of vulnerability management.

---

# 👤 Phase 2 — Identity & Access Management

User accounts were reviewed and configured according to the **Principle of Least Privilege**.

The goal was to avoid using privileged accounts for routine activities and to separate administrative access from normal user activity.

### Example: Create a Standard User

```bash
sudo adduser labuser
```

The new account can then be used for normal activities without automatically granting administrative privileges.

### Security Principle

> Users should receive only the permissions required to perform their assigned tasks.

This reduces the potential impact of compromised credentials.

---

# 👥 Phase 3 — Group Management

Linux groups provide a practical way to manage permissions for multiple users.

A dedicated group can be created with:

```bash
sudo groupadd testusers
```

A user can then be added to the group:

```bash
sudo usermod -aG testusers labuser
```

Membership can be verified with:

```bash
getent group testusers
```

Example output:

```text
testusers:x:1002:labuser
```

### Security Justification

Managing permissions through groups is more scalable than assigning permissions individually to every user.

This approach supports centralized access management and can be extended to role-based access control (RBAC) concepts.

---

# 🔥 Phase 4 — Network Security with UFW

**UFW (Uncomplicated Firewall)** was used to configure host-based network access controls.

First, UFW can be enabled with:

```bash
sudo ufw enable
```

The current firewall configuration can be checked with:

```bash
sudo ufw status verbose
```

### Example Firewall Configuration

For a system that requires SSH and HTTP access:

```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing

sudo ufw allow 22/tcp
sudo ufw allow 80/tcp

sudo ufw deny 23/tcp
```

Then verify the configuration:

```bash
sudo ufw status verbose
```

### Security Justification

The configuration follows a restrictive inbound policy.

* **Port 22/TCP** — SSH, used for secure remote administration.
* **Port 80/TCP** — HTTP, allowed only when the system requires a web service.
* **Port 23/TCP** — Telnet, explicitly denied because Telnet does not provide encrypted communication.

The broader principle is to expose only services that are required by the system.

---

# 🤖 Automation

To extend the practical lab beyond manual command execution, a Bash script was developed to automate user provisioning.

The script:

* Checks for administrative privileges
* Creates a dedicated group if required
* Creates a standard user
* Generates a random password using OpenSSL
* Adds the user to the appropriate group
* Records actions in an audit log
* Displays a summary after completion

Script:

```text
scripts/automate_user_setup.sh
```

Run it with:

```bash
sudo bash scripts/automate_user_setup.sh
```

> **Security note:** The generated password is displayed once during the lab execution. In a production environment, credentials should be handled through an approved secrets-management process rather than printed to the terminal or stored in source control.

---

# 📸 Proof of Work

Evidence from the practical implementation is stored in:

```text
screenshots/
```

### 1. User Group Configuration

```text
screenshots/1_user_groups.png
```

Demonstrates group membership using:

```bash
getent group testusers
```

### 2. UFW Firewall Configuration

```text
screenshots/2_ufw_firewall.png
```

Demonstrates the configured firewall rules using:

```bash
sudo ufw status verbose
```

### 3. Automation Script

```text
screenshots/3_bash_script.png
```

Demonstrates successful execution of:

```bash
sudo bash scripts/automate_user_setup.sh
```

---

# 🧪 Verification

The following commands can be used to verify the configuration.

### Check current user

```bash
whoami
```

### Check group membership

```bash
groups
```

### Check a specific group

```bash
getent group testusers
```

### Check firewall status

```bash
sudo ufw status verbose
```

### Check listening services

```bash
sudo ss -tuln
```

These verification steps help confirm that the intended configuration has actually been applied.

---

# 🛡️ Security Concepts Demonstrated

This project demonstrates practical exposure to:

* Linux system administration
* System hardening
* Patch management
* User account management
* Group-based access control
* Principle of Least Privilege
* Role-Based Access Control concepts
* Host-based firewall configuration
* Network service restriction
* SSH security
* Telnet security risks
* Bash scripting
* OpenSSL-based password generation
* Basic audit logging
* Security verification

---

# 📚 Project Structure

```text
kali-linux-system-hardening/
│
├── README.md
│
├── docs/
│   └── hardening-report.md
│
├── scripts/
│   └── automate_user_setup.sh
│
└── screenshots/
    ├── 1_user_groups.png
    ├── 2_ufw_firewall.png
    └── 3_bash_script.png
```

---

# 💡 Lessons Learned

This lab demonstrated that system hardening is not a single configuration task but a combination of multiple security controls.

Updating software reduces exposure to known vulnerabilities, while proper account and group management limits unauthorized access.

Firewall configuration adds another layer of defense by controlling which network services are accessible.

The automation component also demonstrated how Bash scripting can reduce repetitive administrative work while maintaining consistent security procedures.

---

# 🚀 Future Improvements

Potential improvements for this project include:

* Automated firewall verification
* SSH hardening
* Fail2ban configuration
* Automated security auditing
* Centralized logging
* File integrity monitoring
* CIS benchmark checks
* Automated vulnerability scanning
* Integration with SIEM platforms
* Infrastructure-as-Code implementation

---

# 🎓 Learning Context

This project was completed as part of practical security learning related to the:

**IBM Ethical Hacking with Open Source Tools Professional Certificate**

The repository is intended to demonstrate practical understanding of Linux security hardening, access control, firewall configuration, and basic security automation.

---

## ⚠️ Disclaimer

This project was performed in a controlled learning/lab environment.

Firewall rules, user accounts, and security configurations should be reviewed carefully before being applied to production systems.
