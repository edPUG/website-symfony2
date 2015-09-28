Guest additions with CentOS 7.0 don't seem to install correctly by default. I had to look at this guide for assistance:

http://itekblog.com/centos-7-virtualbox-guest-additions-installation-centos-minimal/

Also install Vagrant Guest Additions plugin https://github.com/dotless-de/vagrant-vbguest

And these commands sorted my issue:
```
vagrant ssh
sudo yum update kernel
sudo yum install gcc make kernel-devel
exit
vagrant halt
vagrant up
```