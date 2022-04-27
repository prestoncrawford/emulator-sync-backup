# Emulator Sync Backup

A humble script for synchronizing save files between SMTP-enabled emulation devices

## Usage

Generate a private key on your local computer if you haven't already done so. 

For example:

```bash
ssh-keygen -t rsa -C "<your email address>"
```

Use `ssh-copy-id` to install key on your handheld device

```bash
ssh-copy-id root@<ip address of your device>
```

Make the script executable

```bash
chmod u+x synchronizeSaves.sh
```

Modify synchronizeSaves.sh, adding your device names, and then the associated URLs and supported consoles (should match Retroarch games naming schemes)

Run synchronizeSaves.sh passing flags to the script for the starting device, the destination device and the console to synchronizeSaves

```bash
synchronizeSaves.sh -s 351v -d 351p -c nes
```
