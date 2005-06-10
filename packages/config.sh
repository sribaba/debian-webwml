# Configuration for packages.debian.org
#

topdir=/org/packages.ubuntu.com

tmpdir=${topdir}/tmp
bindir=${topdir}/bin
scriptdir=${topdir}/htmlscripts
libdir=${topdir}/lib
filesdir=${topdir}/files
htmldir=${topdir}/www
archivedir=${topdir}/archive
podir=${topdir}/po
localedir=${topdir}/locale

# unset this if packages.debian.org moves somewhere where the packages files
# cannot be obtained locally
#
localdir=/org/archive.ubuntu.com

ftpsite=http://archive.ubuntu.com/ubuntu
#nonus_ftpsite=http://ftp.uk.debian.org/debian-non-US
security_ftpsite=$ftpsite
# path to private ftp directory
#ftproot=/org/ftp.root

# Architectures
#
polangs="de nl"
ddtplangs="de cs da eo es fi fr hu it ja nl pl pt_BR pt_PT ru sk sv_SE uk"
parts="main multiverse restricted universe"
dists="hoary warty breezy"
arch_warty="i386 amd64 powerpc"
arch_hoary="${arch_warty}"
arch_warty_updates="${arch_warty}"
arch_breezy="${arch_warty}"
arch_hoary_updates="${arch_warty}"

# Miscellaneous
#
admin_email="djpig@debian.org"
