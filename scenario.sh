#!/bin/bash
sudo -s
yum update -y
rm -fr /etc/localtime
ln -s /usr/share/zoneinfo/Europe/Kiev /etc/localtime
yum install ntp ntpdate -y
ntpdate pool.ntp.org
systemctl enable ntpd
systemctl start ntpd
yum install wget whois net-tools zip unzip -y

#yum install openldap openldap-clients openldap-servers openldap nss-pam-ldapd -y
yum install samba-common samba samba-client -y
cp /etc/samba/smb.conf /etc/samba/smb.conf.bak
cp /vagrant/smb.conf /etc/samba/smb.conf

systemctl start smb
systemctl start nmb

#Create groups
groupadd -g 200 machine
groupadd -g 207 Domain_Guests
groupadd -g 206 Domain_Users
groupadd -g 205 Domain_Admins

#net groupmap add rid=515 ntgroup="Domain Computers" unixgroup=machine
net groupmap add rid=514 ntgroup="Domain Guests" unixgroup=Domain_Guests
net groupmap add rid=513 ntgroup="Domain Users" unixgroup=Domain_Users
net groupmap add rid=512 ntgroup="Domain Admins" unixgroup=Domain_Admins

#Create Samba Dirs
#chmod -R 777 /var/lib/samba/
cp -R /vagrant/netlogon /var/lib/samba/
chmod -R 755 /var/lib/samba/netlogon
mkdir -m 0777 /var/lib/samba/mailbox
mkdir -m 0777 /var/lib/samba/profiles
mkdir -m 0777 /var/lib/samba/userbox
mkdir -m 0777 /var/lib/samba/opt
mkdir -m 0777 /var/lib/samba/post

#Create Machine accounts
smbpasswd -m -a testcomp$
smbpasswd -m -a testcomp2$
smbpasswd -m -a testcomp3$

#Create User accounts
proot=$(cat /vagrant/passwd/root)
ptest1=$(cat /vagrant/passwd/test1)
ptest2=$(cat /vagrant/passwd/test2) 
(echo $proot; echo $proot) | smbpasswd -s -a root
(echo $ptest1; echo $ptest1) | smbpasswd -s -a test1
(echo $ptest2; echo $ptest2) | smbpasswd -s -a test2

#Add root to Domain Admins group with all rights
usermod -g Domain_Admins root
net sam rights grant "Domain Admins" SeMachineAccountPrivilege SeTakeOwnershipPrivilege SeBackupPrivilege SeRestorePrivilege SeRemoteShutdownPrivilege SePrintOperatorPrivilege SeAddUsersPrivilege SeDiskOperatorPrivilege -Uroot%proot

systemctl enable smb.service
systemctl enable nmb.service
systemctl restart smb
systemctl restart nmb

#Settings of firewalld ang selinux
systemctl disable firewalld
SELINUX=disabled