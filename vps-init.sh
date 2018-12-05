#!/bin/bash
# Script de arranque de VPS OVH
# 1. Cambiar root pwd
# 2. Setear hostname como parámetro 1
#
if [ $# -eq 0 ]
then
  echo Colocar el nombre del host (ej. my.vps.cb)

else
 #cambio de contraseña
  passwd

 #actualización de repositorio
  yum clean all
  rm -rf /var/cache/yum
  yum makecache
  yum -y install wget
  yum -y install nano
  yum -y update

 #crear swap file
  fallocate -l 1G /swapfile
  chmod 600 /swapfile
  mkswap /swapfile
  swapon /swapfile

 #configurar swap a permanente
  echo "/swapfile swap swap defaults 0 0" >> /etc/fstab
  echo "vm.swappiness = 10" >> /etc/sysctl.conf
  echo "vm.vfs_cache_pressure = 50" >> /etc/sysctl.conf

 #actualizar el nombre del host
  hostnamectl set-hostname $1

 #descargar cwp
  cd /usr/local/src
  wget http://centos-webpanel.com/cwp-el7-latest

 #reiniciar
  init 6
fi