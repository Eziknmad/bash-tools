#!/bin/bash
# 👆 Shebang: tells the system to use Bash to run this script.

# -------------------------------------------------------------
# This script checks disk usage and alerts if usage is above 80%
# -------------------------------------------------------------

# 🧮 Step 1: Get the disk usage of the root partition (/)
# 'df /' shows disk usage of the root filesystem.
# Example output:
# Filesystem     1K-blocks    Used Available Use% Mounted on
# /dev/sda1       30432960 16839136  12002592  59% /
#
# 'tail -1' takes the last line (so we skip the header).
# 'awk "{print $5}"' extracts the 5th column — the usage percentage (e.g. "59%").
# 'sed "s/%//"' removes the '%' sign to get just the number.
usage=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')

# 🖨️ Step 2: Display current disk usage
echo "Current disk usage: $usage%"

# 🧠 Step 3: Compare usage against the threshold (80%)
# -gt means "greater than" in Bash arithmetic comparison.
# If usage > 80, print a warning; otherwise, print a safe message.
if [ "$usage" -gt 80 ]; then
    # 🚨 Disk usage above threshold
    echo "Warning: Disk usage is above 80%!"
else
    # ✅ Disk usage below threshold
    echo "Disk usage is under control."
fi

