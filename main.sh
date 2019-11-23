#! /usr/bin/env sh

wd=$(pwd)
sudo rm -rf tmp mnt
mkdir -p tmp mnt

sudo mount -t iso9660 -o loop $1 $wd/mnt
cd $wd/mnt
tar cf - . | (cd $wd/tmp; tar xfp -)

sudo wget -c $wd/tmp/EFI/boot/bootia32.efi https://github.com/hirotakaster/baytail-bootia32.efi/raw/master/bootia32.efi

cd $wd/tmp
mkisofs -o update-$1 -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -J -R -V "32Bit UEFI .iso"

sudo umount $wd/mnt