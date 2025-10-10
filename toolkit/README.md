# 🧰 Linux Admin Toolkit

### Author: Kevin Galarza Arzon  
### Script: `interactive_toolkit.sh`

---

## 📖 Overview

**Linux Admin Toolkit** is an interactive Bash utility designed to simplify common system administration tasks for beginners and intermediate users.  
It provides a colorful terminal menu interface to quickly monitor disk usage, logged-in users, SSH login attempts, and user-specific processes — all while logging each action automatically.

---

## 🚀 Features

- ✅ **Disk Usage Check** — View disk space usage across mounted drives.  
- 👥 **Logged-In Users** — See who’s currently logged into the system.  
- 🔐 **Failed SSH Logins** — Display recent failed login attempts from `/var/log/auth.log`.  
- 🧑‍💻 **User Process Viewer** — Check running processes for a specific user.  
- 🗂️ **Action Logging** — All actions are logged to `toolkit.log` with timestamps.  
- ⚠️ **Graceful Exit Handling** — Catches `Ctrl + C` interruptions cleanly using `trap`.

---

## 🧩 File Structure

---

## ⚙️ Prerequisites

Make sure your environment meets the following requirements:

- **Operating System:** Linux (Ubuntu, Debian, Fedora, etc.)  
- **Shell:** Bash (`/bin/bash`)  
- **Permissions:**  
  - Regular user access for most commands  
  - `sudo` privileges if reading `/var/log/auth.log`

---

## 💻 Installation & Setup

1. **Clone or copy** the toolkit directory to your Linux system:
   ```bash
   git clone https://github.com/<your-username>/toolkit.git
   cd toolkit
