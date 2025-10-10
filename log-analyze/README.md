

# 📊 Log Analyze Toolkit

### Author: Kevin Galarza Arzon  
### Scripts: `parse_log.py` & `log_parser_v2.sh`

---

## 📖 Overview

The **Log Analyze Toolkit** is a lightweight pair of scripts — one written in **Python** and one in **Bash** — designed to help system administrators quickly identify **failed SSH login attempts** and detect potential **brute-force attacks** in Linux authentication logs.

Both scripts scan the `auth.log` file, extract IP addresses from failed SSH attempts, and summarize the data in a clean, human-readable format.  
The Bash version even includes **colored output**, **functions**, and **threshold detection** for suspicious activity.

---

## 🧩 File Structure

---

## ⚙️ Requirements

| Requirement | Description |
|--------------|-------------|
| **OS** | Linux (tested on Ubuntu/Debian) |
| **Log File** | `/var/log/auth.log` (or a copy in the current directory) |
| **Permissions** | May require `sudo` to read system logs |
| **Python Version** | Python 3.x (for `parse_log.py`) |
| **Bash Version** | Bash 4 or newer (for `log_parser_v2.sh`) |

---

## 🐍 `parse_log.py` — Python Log Parser

### 🧠 Purpose
This script reads a local copy of the authentication log and reports **failed SSH login attempts per IP address**, showing only IPs with more than two failures (a simple brute-force indicator).

### ▶️ Usage
1. Place your `auth.log` file in the same folder as the script.  
2. Run:
   ```bash
   python3 parse_log.py
