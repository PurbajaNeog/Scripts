#!/bin/bash

# Usage: ./perm_scan.sh [directory] [report_file]
# Example: ./perm_scan.sh /home/user report.txt

DIR="${1:-.}"
REPORT="${2:-perm_report.txt}"

if [ ! -d "$DIR" ]; then
    echo "Error: '$DIR' is not a directory"
    exit 1
fi

{
echo "Permission scan of: $DIR"
echo "Date: $(date)"
echo "=========================================="

echo
echo "[1] World-writable files (anyone can modify):"
find "$DIR" -type f -perm -0002 

echo
echo "[2] World-writable directories WITHOUT sticky bit:"
find "$DIR" -type d -perm -0002 ! -perm -1000 

echo
echo "[3] SUID files (run with owner's privileges):"
find "$DIR" -type f -perm -4000 

echo
echo "[4] SGID files (run with group's privileges):"
find "$DIR" -type f -perm -2000 

echo
echo "[5] Files with 777 permissions:"
find "$DIR" -type f -perm 0777 

echo
echo "[6] Files with no valid owner or group:"
find "$DIR" -type f \( -nouser -o -nogroup \)

echo
echo "[7] Private keys / config files readable by others:"
find "$DIR" -type f \( -name "*.pem" -o -name "id_rsa" -o -name "*.key" -o -name ".env" \) -perm -0004 

echo
echo "=========================================="
echo "Scan complete."
} > "$REPORT"

echo
echo "Report saved to: $REPORT"
