# Scripts

## Contents
 
| Script | Purpose |
|--------|---------|
| `file_perm.sh` | Scans a directory and reports files with insecure permissions |
| `encrypt_decrypt.sh` | [Encrypts and decrypts files from the command line, using ___ (e.g., openssl / gpg)] |

## 1. file_perm.sh: Permission Scanner
 
Scans a directory and reports potentially risky files so they can be reviewed and fixed.
 
### What it detects
- World-writable files and directories
- Files with `777` permissions
- SUID / SGID files (possible privilege escalation paths)
- Files with no valid owner or group
- [Sensitive files such as `.env` or private keys readable by others]

## 2. encrypt_decrypt.sh: File Encryption Tool
 
Encrypts and decrypts a single file using GnuPG (GPG) with symmetric, passphrase-based encryption.

### How it works
- Checks that exactly two arguments are given and that the file exists.
- For `decrypt`, requires the file to end in `.gpg`.
- `encrypt` runs `gpg --symmetric`, which asks for a passphrase twice and writes `FILE.gpg`.
- `decrypt` runs `gpg --decrypt` and writes the output to the original filename (the `.gpg` suffix removed).
- Anyone with the passphrase can decrypt the file, so choose a strong one. A lost passphrase cannot be recovered.
