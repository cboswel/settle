#!/bin/bash
for i in /dev /dev/pts /proc /sys /run; do sudo mount -B $i /mnt$i; done

sudo chroot /mnt
