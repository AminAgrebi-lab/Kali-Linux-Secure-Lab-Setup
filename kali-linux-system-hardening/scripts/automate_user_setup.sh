```bash
#!/bin/bash

# ============================================================
# Kali Linux System Hardening
# Automated User Provisioning Script
# Author: Amin Agrebi
# ============================================================

set -euo pipefail

# -----------------------------
# Configuration
# -----------------------------

USERNAME="${1:-labuser}"
GROUP_NAME="${2:-testusers}"
LOG_FILE="/var/log/user_setup.log"

# -----------------------------
# Functions
# -----------------------------

log_message() {
    local MESSAGE="$1"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $MESSAGE" | tee -a "$LOG_FILE"
}

error_exit() {
    echo "[ERROR] $1" >&2
    exit 1
}

# -----------------------------
# Root Privilege Check
# -----------------------------

if [[ "$EUID" -ne 0 ]]; then
    error_exit "This script must be executed with root privileges."
fi

# -----------------------------
# Input Validation
# -----------------------------

if [[ ! "$USERNAME" =~ ^[a-z_][a-z0-9_-]*$ ]]; then
    error_exit "Invalid username: $USERNAME"
fi

if [[ ! "$GROUP_NAME" =~ ^[a-z_][a-z0-9_-]*$ ]]; then
    error_exit "Invalid group name: $GROUP_NAME"
fi

# -----------------------------
# Initialize Log
# -----------------------------

touch "$LOG_FILE"
chmod 600 "$LOG_FILE"

log_message "Starting automated user setup."

# -----------------------------
# Create Group
# -----------------------------

if getent group "$GROUP_NAME" > /dev/null 2>&1; then
    log_message "Group '$GROUP_NAME' already exists."
else
    groupadd "$GROUP_NAME"
    log_message "Created group '$GROUP_NAME'."
fi

# -----------------------------
# Create User
# -----------------------------

if id "$USERNAME" > /dev/null 2>&1; then
    log_message "User '$USERNAME' already exists."
else
    useradd -m -s /bin/bash "$USERNAME"
    log_message "Created user '$USERNAME'."
fi

# -----------------------------
# Generate Temporary Password
# -----------------------------

PASSWORD="$(openssl rand -base64 18)"

echo "${USERNAME}:${PASSWORD}" | chpasswd

# Force password change on first login
chage -d 0 "$USERNAME"

log_message "Generated temporary credential for '$USERNAME'."

# -----------------------------
# Add User to Group
# -----------------------------

usermod -aG "$GROUP_NAME" "$USERNAME"

log_message "Added '$USERNAME' to group '$GROUP_NAME'."

# -----------------------------
# Verification
# -----------------------------

if id "$USERNAME" > /dev/null 2>&1; then
    log_message "User verification successful."
else
    error_exit "User verification failed."
fi

if id -nG "$USERNAME" | grep -qw "$GROUP_NAME"; then
    log_message "Group membership verification successful."
else
    error_exit "Group membership verification failed."
fi

# -----------------------------
# Completion Message
# -----------------------------

echo
echo "=========================================="
echo "        Setup Complete!"
echo "=========================================="
echo
echo "Username : $USERNAME"
echo "Group    : $GROUP_NAME"
echo
echo "Temporary password:"
echo "$PASSWORD"
echo
echo "The user will be required to change"
echo "the password at first login."
echo
echo "Audit log:"
echo "$LOG_FILE"
echo
echo "=========================================="

log_message "Automated user setup completed successfully."
```
