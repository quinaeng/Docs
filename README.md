[root@smzlog01 etc]# cd /etc/aut
authselect/            auto.master            auto.master.org        auto.misc.org          auto.smb               autofs_ldap_auth.conf
auto.backup            auto.master.d/         auto.misc              auto.net               autofs.conf
[root@smzlog01 etc]# cd /etc/aut^C
[root@smzlog01 etc]# cat /etc/auto.master
#
# Sample auto.master file
# This is a 'master' automounter map and it has the following format:
# mount-point [map-type[,format]:]map [options]
# For details of the format look at auto.master(5).
#
/misc   /etc/auto.misc
#
# NOTE: mounts done from a hosts map will be mounted with the
#       "nosuid" and "nodev" options unless the "suid" and "dev"
#       options are explicitly given.
#
/net    -hosts
#
# Include /etc/auto.master.d/*.autofs
# To add an extra map using this mechanism you will need to add
# two configuration items - one /etc/auto.master.d/extra.autofs file
# (using the same line format as the auto.master file)
# and a separate mount map (e.g. /etc/auto.extra or an auto.extra NIS map)
# that is referred to by the extra.autofs file.
#
+dir:/etc/auto.master.d
#
# If you have fedfs set up and the related binaries, either
# built as part of autofs or installed from another package,
# uncomment this line to use the fedfs program map to access
# your fedfs mounts.
#/nfs4  /usr/sbin/fedfs-map-nfs4 nobind
#
# Include central master map if it can be found using
# nsswitch sources.
#
# Note that if there are entries for /net or /misc (as
# above) in the included master map any keys that are the
# same will not be seen as the first read key seen takes
# precedence.
#
# +auto.master
/mnt /etc/auto.backup --timeout=30
[root@smzlog01 etc]#
[root@smzlog01 etc]# cat /etc/auto.
auto.backup      auto.master      auto.master.d/   auto.master.org  auto.misc        auto.misc.org    auto.net         auto.smb
[root@smzlog01 etc]# cat /etc/auto.backup
backup  -fstype=ext4    :dev/sdb1

[root@smzlog01 etc]#
