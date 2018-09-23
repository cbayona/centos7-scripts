yum clean all
rm -rf /var/cache/yum
yum makecache
yum -y install wget
yum -y install nano
yum -y update
