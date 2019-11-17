lsblk
umount /dev/sdXx
lsblk
dd if=debian-8.11.1-amd64-DVD-1.iso of=/dev/sdXx bs=4M status=progress && sync
