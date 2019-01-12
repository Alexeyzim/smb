#!/bin/bash
sudo -s
yum update -y
rm -fr /etc/localtime
ln -s /usr/share/zoneinfo/Europe/Kiev /etc/localtime
yum install ntp ntpdate -y
ntpdate pool.ntp.org
systemctl enable ntpd
systemctl start ntpd
yum install wget whois net-tools zip unzip deltarpm -y
yum install samba* -y
cp /etc/samba/smb.conf /etc/samba/smb.conf.bak
cp /vagrant/smb.conf /etc/samba/smb.conf

systemctl start smb
systemctl start nmb
systemctl enable smb
systemctl enable nmb
#main editor
export EDITOR=mcedit

#Create groups
groupadd -g 200 machine
groupadd -g 207 Domain_Guests
groupadd -g 206 Domain_Users
groupadd -g 205 Domain_Admins

net groupmap add rid=515 ntgroup="Domain Computers" unixgroup=machine
net groupmap add rid=514 ntgroup="Domain Guests" unixgroup=Domain_Guests
net groupmap add rid=513 ntgroup="Domain Users" unixgroup=Domain_Users
net groupmap add rid=512 ntgroup="Domain Admins" unixgroup=Domain_Admins

#Create Samba Dirs
cp -R /vagrant/netlogon /var/lib/samba/
chmod -R 755 /var/lib/samba/netlogon
mkdir -m 0777 /var/lib/samba/mailbox
mkdir -m 0777 /var/lib/samba/cashbox
mkdir -m 0777 /var/lib/samba/profiles
mkdir -m 0777 /var/lib/samba/userbox
mkdir -m 0777 /var/lib/samba/opt
mkdir -m 0777 /var/lib/samba/post

#Create Machine accounts
smbpasswd -m -a arc$
smbpasswd -m -a designer$
smbpasswd -m -a fin1$
smbpasswd -m -a fin2$
smbpasswd -m -a fin3$
smbpasswd -m -a fin4$
smbpasswd -m -a finrem$
smbpasswd -m -a hr_comp$
smbpasswd -m -a ironfelix$
smbpasswd -m -a keracomp_boss$
smbpasswd -m -a keracomp_buh$
smbpasswd -m -a keracomp_buh1$
smbpasswd -m -a keracomp_buh2$
smbpasswd -m -a keracomp_buh3$
smbpasswd -m -a keracomp_cash$
smbpasswd -m -a keracomp-dir$
smbpasswd -m -a keracomp-dir1$
smbpasswd -m -a logist$
smbpasswd -m -a note1$
smbpasswd -m -a opt1$
smbpasswd -m -a opt3$
smbpasswd -m -a opt4$
smbpasswd -m -a opt5$
smbpasswd -m -a opt6$
smbpasswd -m -a opt7$
smbpasswd -m -a opt8$
smbpasswd -m -a postach_import$
smbpasswd -m -a postach_plitka$
smbpasswd -m -a postach_import$
smbpasswd -m -a project$
smbpasswd -m -a project1$
smbpasswd -m -a reklamacomp$
smbpasswd -m -a reklamacomp1$
smbpasswd -m -a reklamacomp2$
smbpasswd -m -a rozdribcomp$
smbpasswd -m -a rozdribcomp1$
smbpasswd -m -a rozdribcomp2$
smbpasswd -m -a rozdribcomp3$
smbpasswd -m -a rozdribcomp4$
smbpasswd -m -a store_comp$
smbpasswd -m -a vmxp$
smbpasswd -m -a zal_plitka$
smbpasswd -m -a zal_plitka1$
smbpasswd -m -a zal_plitka2$
smbpasswd -m -a zal_plitka3$
smbpasswd -m -a zal_santech$
smbpasswd -m -a zal_santech1$

#Create User accounts
proot=$(cat /vagrant/passwd/root)
pbuhgalter=$(cat /vagrant/passwd/buhgalter)
pbuhgalter1=$(cat /vagrant/passwd/buhgalter1)
pbuhgalter2=$(cat /vagrant/passwd/buhgalter2)
pfinance1=$(cat /vagrant/passwd/finance1)
pfinance2=$(cat /vagrant/passwd/finance2)
pfinance3=$(cat /vagrant/passwd/finance3)
pfinance4=$(cat /vagrant/passwd/finance4)
pfinance5=$(cat /vagrant/passwd/finance5)
pgreen=$(cat /vagrant/passwd/green) 
pimport=$(cat /vagrant/passwd/import)
pkasa1=$(cat /vagrant/passwd/kasa1)
pkasa2=$(cat /vagrant/passwd/kasa2)
pkons=$(cat /vagrant/passwd/kons)
pkons1=$(cat /vagrant/passwd/kons1)
pkons2=$(cat /vagrant/passwd/kons2)
pkons3=$(cat /vagrant/passwd/kons3)
pkons4=$(cat /vagrant/passwd/kons4)
pkons5=$(cat /vagrant/passwd/kons5)
pkons6=$(cat /vagrant/passwd/kons6)
pkons7=$(cat /vagrant/passwd/kons7)
pkons8=$(cat /vagrant/passwd/kons8)
pkons9=$(cat /vagrant/passwd/kons9)
pkons10=$(cat /vagrant/passwd/kons10)
plesya=$(cat /vagrant/passwd/lesya)
pmanager1=$(cat /vagrant/passwd/manager1)
pmanager2=$(cat /vagrant/passwd/manager2)
pmanager3=$(cat /vagrant/passwd/manager3)
pmanager4=$(cat /vagrant/passwd/manager4)
pmanager5=$(cat /vagrant/passwd/manager5)
pmanager6=$(cat /vagrant/passwd/manager6)
pmanager7=$(cat /vagrant/passwd/manager7)
pmanager9=$(cat /vagrant/passwd/manager9)
pmanager10=$(cat /vagrant/passwd/manager10)
pmanager11=$(cat /vagrant/passwd/manager11)
pmanager12=$(cat /vagrant/passwd/manager12)
poksana_b=$(cat /vagrant/passwd/oksana_b)
polena_s=$(cat /vagrant/passwd/olena_s)
porder=$(cat /vagrant/passwd/order)
porder1=$(cat /vagrant/passwd/order1)
porder2=$(cat /vagrant/passwd/order2)
porder3=$(cat /vagrant/passwd/order3)
porder4=$(cat /vagrant/passwd/order4)
pov=$(cat /vagrant/passwd/ov)
pplitka=$(cat /vagrant/passwd/plitka)
preklama=$(cat /vagrant/passwd/reklama)
preklama1=$(cat /vagrant/passwd/reklama1)
preklama2=$(cat /vagrant/passwd/reklama2)
prozdrib=$(cat /vagrant/passwd/rozdrib)
prozdrib1=$(cat /vagrant/passwd/rozdrib1)
prozdrib2=$(cat /vagrant/passwd/rozdrib2)
prozdrib3=$(cat /vagrant/passwd/rozdrib3)
prozdrib4=$(cat /vagrant/passwd/rozdrib4)
prozdrib5=$(cat /vagrant/passwd/rozdrib5)
psantech=$(cat /vagrant/passwd/santech)
pstore=$(cat /vagrant/passwd/store)
ptech=$(cat /vagrant/passwd/tech)
pvickos=$(cat /vagrant/passwd/vickos)

(echo $proot; echo $proot) | smbpasswd -s -a root
(echo $pbuhgalter; echo $pbuhgalter) | smbpasswd -s -a buhgalter
(echo $pbuhgalter1; echo $pbuhgalter1) | smbpasswd -s -a buhgalter1
(echo $pbuhgalter2; echo $pbuhgalter2) | smbpasswd -s -a buhgalter2
(echo $pfinance1; echo $pfinance1) | smbpasswd -s -a finance1
(echo $pfinance2; echo $pfinance2) | smbpasswd -s -a finance2
(echo $pfinance3; echo $pfinance3) | smbpasswd -s -a finance3
(echo $pfinance4; echo $pfinance4) | smbpasswd -s -a finance4
(echo $pfinance5; echo $pfinance5) | smbpasswd -s -a finance5
(echo $pgreen; echo $pgreen) | smbpasswd -s -a green
(echo $pimport; echo $pimport) | smbpasswd -s -a import
(echo $pkasa1; echo $pkasa1) | smbpasswd -s -a kasa1
(echo $pkasa2; echo $pkasa2) | smbpasswd -s -a kasa2
(echo $pkons1; echo $pkons1) | smbpasswd -s -a kons1
(echo $pkons2; echo $pkons2) | smbpasswd -s -a kons2
(echo $pkons3; echo $pkons3) | smbpasswd -s -a kons3
(echo $pkons4; echo $pkons4) | smbpasswd -s -a kons4
(echo $pkons5; echo $pkons5) | smbpasswd -s -a kons5
(echo $pkons6; echo $pkons6) | smbpasswd -s -a kons6
(echo $pkons7; echo $pkons7) | smbpasswd -s -a kons7
(echo $pkons8; echo $pkons8) | smbpasswd -s -a kons8
(echo $pkons9; echo $pkons9) | smbpasswd -s -a kons9
(echo $pkons10; echo $pkons10) | smbpasswd -s -a kons10
(echo $plesya; echo $plesya) | smbpasswd -s -a lesya
(echo $pmanager1; echo $pmanager1) | smbpasswd -s -a manager1
(echo $pmanager2; echo $pmanager2) | smbpasswd -s -a manager2
(echo $pmanager3; echo $pmanager3) | smbpasswd -s -a manager3
(echo $pmanager4; echo $pmanager4) | smbpasswd -s -a manager4
(echo $pmanager5; echo $pmanager5) | smbpasswd -s -a manager5
(echo $pmanager6; echo $pmanager6) | smbpasswd -s -a manager6
(echo $pmanager7; echo $pmanager7) | smbpasswd -s -a manager7
(echo $pmanager9; echo $pmanager9) | smbpasswd -s -a manager9
(echo $pmanager10; echo $pmanager10) | smbpasswd -s -a manager10
(echo $pmanager11; echo $pmanager11) | smbpasswd -s -a manager11
(echo $pmanager12; echo $pmanager12) | smbpasswd -s -a manager12
(echo $poksana_b; echo $poksana_b) | smbpasswd -s -a oksana_b
(echo $polena_s; echo $polena_s) | smbpasswd -s -a olena_s
(echo $porder; echo $porder) | smbpasswd -s -a order
(echo $porder1; echo $porder1) | smbpasswd -s -a order1
(echo $porder2; echo $porder2) | smbpasswd -s -a order2
(echo $porder3; echo $porder3) | smbpasswd -s -a order3
(echo $porder4; echo $porder4) | smbpasswd -s -a order4
(echo $pov; echo $pov) | smbpasswd -s -a ov
(echo $pplitka; echo $pplitka) | smbpasswd -s -a plitka
(echo $preklama; echo $preklama) | smbpasswd -s -a reklama
(echo $preklama1; echo $preklama1) | smbpasswd -s -a reklama1
(echo $preklama2; echo $preklama2) | smbpasswd -s -a reklama2
(echo $prozdrib; echo $prozdrib) | smbpasswd -s -a rozdrib
(echo $prozdrib1; echo $prozdrib1) | smbpasswd -s -a rozdrib1
(echo $prozdrib2; echo $prozdrib2) | smbpasswd -s -a rozdrib2
(echo $prozdrib3; echo $prozdrib3) | smbpasswd -s -a rozdrib3
(echo $prozdrib4; echo $prozdrib4) | smbpasswd -s -a rozdrib4
(echo $prozdrib5; echo $prozdrib5) | smbpasswd -s -a rozdrib5
(echo $psantech; echo $psantech) | smbpasswd -s -a santech
(echo $pstore; echo $pstore) | smbpasswd -s -a store
(echo $ptech; echo $ptech) | smbpasswd -s -a tech
(echo $pvickos; echo $pvickos) | smbpasswd -s -a vickos

#Add root to Domain Admins group with all rights
usermod -g Domain_Admins root
net sam rights grant "Domain Admins" SeMachineAccountPrivilege SeTakeOwnershipPrivilege SeBackupPrivilege SeRestorePrivilege SeRemoteShutdownPrivilege SePrintOperatorPrivilege SeAddUsersPrivilege SeDiskOperatorPrivilege -Uroot%proot

net rpc join -Uroot%$proot
systemctl restart smb
systemctl restart nmb

#Settings of firewalld ang selinux
##Firewalld
firewall-cmd --add-service samba
firewall-cmd --add-service samba --permanent
firewall-cmd --permanent --add-port=53/tcp
firewall-cmd --permanent --add-port=53/udp
firewall-cmd --permanent --add-port=88/tcp
firewall-cmd --permanent --add-port=88/udp
firewall-cmd --permanent --add-port=135/tcp
firewall-cmd --permanent --add-port=137/tcp
firewall-cmd --permanent --add-port=137/udp
firewall-cmd --permanent --add-port=138/udp
firewall-cmd --permanent --add-port=139/tcp
firewall-cmd --permanent --add-port=389/tcp
firewall-cmd --permanent --add-port=389/udp
firewall-cmd --permanent --add-port=445/tcp
firewall-cmd --permanent --add-port=464/tcp
firewall-cmd --permanent --add-port=464/udp
firewall-cmd --permanent --add-port=636/tcp
firewall-cmd --permanent --add-port=953/tcp
firewall-cmd --permanent --add-port=953/udp
firewall-cmd --permanent --add-port=1024-5000/tcp
firewall-cmd --permanent --add-port=1024-5000/udp
firewall-cmd --permanent --add-port=3268/tcp
firewall-cmd --permanent --add-port=3269/tcp
firewall-cmd --permanent --add-port=5353/tcp
firewall-cmd --permanent --add-port=5353/udp
systemctl restart firewalld
##Selinux
setsebool -P samba_domain_controller on
setsebool -P samba_enable_home_dirs on
chcon -t samba_share_t /var/lib/samba/netlogon
chcon -t samba_share_t /var/lib/samba/profiles
chcon -t samba_share_t /var/lib/samba/userbox
chcon -t samba_share_t /var/lib/samba/cashbox
chcon -t samba_share_t /var/lib/samba/mailbox
chcon -t samba_share_t /var/lib/samba/opt
chcon -t samba_share_t /var/lib/samba/post