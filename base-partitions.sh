## swap partition
#dd if=/dev/zero of=/dev/mapper/swap.partition bs=1024 count=1048576
#mkswap /swapfile
#chmod 0600 /dev/mapper/swap.partition
#swapon /dev/mapper/swap.partition

## tmp partition
dd if=/dev/zero of=/dev/mapper/tmp.partition bs=1024 count=262144
/sbin/mke2fs /tmp.partition
mount -o defaults,nosuid,noexec,nodev /tmp.partition /tmp
chmod 3777 /tmp

## var partition
dd if=/dev/zero of=/dev/mapper/var.partition bs=1024 count=524288
/sbin/mke2fs /var.partition
mount -o defaults,nosuid,noexec,nodev /var.partition /var

## var/tmp partition
dd if=/dev/zero of=/dev/mapper/var_tmp.partition bs=1024 count=524288
/sbin/mke2fs /var_tmp.partition
mount -o defaults,nosuid,noexec,nodev /var_tmp.partition /var/tmp

## var/log partition
mount -o defaults,nosuid,noexec,nodev /var_tmp.partition /var/log

## var/log/audit partition
mount -o defaults,nosuid,noexec,nodev /var_tmp.partition /var/log/audit

## home partition
dd if=/dev/zero of=/dev/mapper/home.partition bs=1024 count=4194304
/sbin/mke2fs /home.partition
mount -o defaults,nosuid,noexec,nodev /home.partition /home

## add to conf file
echo "/dev/mapper/home.partition /home                   xfs     defaults        0 0" >> /etc/fstab
echo "/dev/mapper/tmp.partition /tmp                    xfs     defaults,nosuid,noexec,nodev        0 0" >> /etc/fstab
echo "/dev/mapper/var.partition /var                    xfs     defaults,nosuid        0 0" >> /etc/fstab
echo "/dev/mapper/var_tmp.partition /var/tmp                xfs     defaults,nosuid,noexec,nodev        0 0" >> /etc/fstab
echo "/dev/mapper/var_tmp.partition /var/log                xfs     defaults,nosuid,noexec,nodev        0 0" >> /etc/fstab
echo "/dev/mapper/var_tmp.partition /var/log/audit                xfs     defaults,nosuid,noexec,nodev        0 0" >> /etc/fstab
#echo "/dev/mapper/swap.partition swap                    swap    defaults        0 0" >> /etc/fstab
