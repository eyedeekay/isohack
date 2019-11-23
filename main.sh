#! /usr/bin/env sh

rm -rf tmp
mkdir -p tmp mnt

sudo mount -t iso9660 -o loop $1 $(pwd)/mnt
tar cf - $(pwd)/mnt | (cd $(pwd)/tmp; tar xfp -)

wget -c $(pwd)/tmp/EFI/boot https://github.com/hirotakaster/baytail-bootia32.efi/raw/master/bootia32.efi

mkisofs -o update-$1 -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -J -R -V "$1 Customized" $(pwd)/tmp

sudo umount $(pwd)/mnt