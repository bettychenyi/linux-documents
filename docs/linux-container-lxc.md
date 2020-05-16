## lxc: Linux Container

### From wikipedia:

LXC (Linux Containers) is an operating-system-level virtualization method for running ```multiple isolated Linux systems (containers)``` 
on a control host ```using a single Linux kernel```.

The Linux kernel provides the ```cgroups``` functionality that allows limitation and prioritization of resources
(CPU, memory, block I/O, network, etc.) without the need for starting any virtual machines, 
and also ```namespace isolation``` functionality that allows complete isolation of an application's view of the operating environment, 
including process trees, networking, user IDs and mounted file systems.

LXC combines the kernel's ```cgroups``` and support for ```isolated namespaces``` to provide an isolated environment for applications.
Early versions of Docker used LXC as the container execution driver, though LXC was made optional in v0.9 and support was dropped in Docker v1.10.

So, docker and lxc are now two technologies used to support Linux Container.

## lxc container on Ubuntu 1804

### Install lxc on Ubuntu 1804

```
betty@ubuntu1804:~# apt update
betty@ubuntu1804:~# apt install lxc lxc-templates bridge-utils
betty@ubuntu1804:~# lxc-checkconfig  # to check everything is okay to runlxc containers 
```

* run ```ifconfig```, we will see a new if device created which is the bridge 

```
lxcbr0: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        inet 10.0.3.1  netmask 255.255.255.0  broadcast 0.0.0.0
```

```
betty@ubuntu1804:~# cat /etc/lxc/default.conf
lxc.net.0.type = veth
lxc.net.0.link = lxcbr0
lxc.net.0.flags = up
lxc.net.0.hwaddr = 00:16:3e:xx:xx:xx
```

```
betty@ubuntu1804:~# cat /etc/default/lxc-net
USE_LXC_BRIDGE="true"
LXC_BRIDGE="lxcbr0"
LXC_ADDR="10.0.3.1"
LXC_NETMASK="255.255.255.0"
LXC_NETWORK="10.0.3.0/24"
LXC_DHCP_RANGE="10.0.3.2,10.0.3.254"
LXC_DHCP_MAX="253"
```

### Create and run lxc on Ubuntu 1804

Yes, for sure, you can create a CentOS or other distro container on Ubuntu.

See what templates have been installed on this machine:
```
betty@ubuntu1804:~# sudo ls /usr/share/lxc/templates/
```

OK, now let's create a Ubuntu container with name of "ubuntu_lxc", by using the ubuntu template:
```
betty@ubuntu1804:~# sudo lxc-create -n ubuntu_lxc -t ubuntu
```

The above step will take few minutes to complete. We will see this after completion (please note the username/password for the container):

```
##
# The default user is 'ubuntu' with password 'ubuntu'!
# Use the 'sudo' command to run tasks as root in the container.
##
```

Now, let's list all of the containers by ```lxc-ls``` and start one by its name:

```
betty@ubuntu1804:~# lxc-start -n ubuntu_lxc -d
```

Now, let's use the container console:

```
betty@ubuntu1804:~# lxc-attach ubuntu_lxc

root@ubuntu_lxc:/etc# hostname
ubuntu_lxc

root@ubuntu_lxc:~# ip addr show | grep inet
    inet 10.0.3.178/24 brd 10.0.3.255 scope global dynamic eth0
    
root@ubuntu_lxc:~# ping www.bing.com
PING dual-a-0001.a-msedge.net (204.79.197.200) 56(84) bytes of data.
64 bytes from a-0001.a-msedge.net (204.79.197.200): icmp_seq=1 ttl=118 time=1.43 ms
64 bytes from a-0001.a-msedge.net (204.79.197.200): icmp_seq=2 ttl=118 time=1.41 ms
...

root@ubuntu_lxc:~# exit
exit
```

### Another way to login the container console (use the username/password shown above)

```
betty@ubuntu1804:~# lxc-console -n ubuntu_lxc

Connected to tty 1
Type <Ctrl+a q> to exit the console, <Ctrl+a Ctrl+a> to enter Ctrl+a itself

Ubuntu 18.04.4 LTS ubuntu_lxc pts/0

ubuntu_lxc login: ubuntu
Password:
Welcome to Ubuntu 18.04.4 LTS (GNU/Linux 5.3.0-1020-azure x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

ubuntu@ubuntu_lxc:~$ hostname
ubuntu_lxc

ubuntu@ubuntu_lxc:~$ ip addr show | grep inet
    inet 127.0.0.1/8 scope host lo
    inet6 ::1/128 scope host
    inet 10.0.3.178/24 brd 10.0.3.255 scope global dynamic eth0
    inet6 fe80::216:3eff:fedb:7142/64 scope link
```

As it says, use ```<Ctrl+a q>``` to exit the console

### manage lxc containers from its host

```
betty@ubuntu1804:~# sudo lxc-ls -f
NAME       STATE   AUTOSTART GROUPS IPV4       IPV6 UNPRIVILEGED
ubuntu_lxc RUNNING 0         -      10.0.3.178 -    false

betty@ubuntu1804:~# lxc-info -n ubuntu_lxc
Name:           ubuntu_lxc
State:          RUNNING
PID:            37274
IP:             10.0.3.178
CPU use:        1.24 seconds
BlkIO use:      36.00 KiB
Memory use:     33.61 MiB
KMem use:       8.68 MiB
Link:           vethWD0NS8
 TX bytes:      4.42 KiB
 RX bytes:      6.01 KiB
 Total bytes:   10.44 KiB
```

* List all containers by ```lxc-ls```
* Destry a container by its name ```lxc-destroy -n ubuntu_lxc_not_used```
* Stop container by it name ```lxc-stop -n ubuntu_lxc```
* Clone the container by names ```lxc-copy -n ubuntu_lxc -N ubuntu_lxc_new``` (Note: You must stop a container before copy it for a new one.)
* Start the new container by its name ```lxc-start -n ubuntu_lxc_new -d```
* Start the original container by its name ```lxc-start -n ubuntu_lxc -d```

Now we will see two containers running:

```
betty@ubuntu1804:~# sudo lxc-ls -f
NAME           STATE   AUTOSTART GROUPS IPV4       IPV6 UNPRIVILEGED
ubuntu_lxc     RUNNING 0         -      10.0.3.178 -    false
ubuntu_lxc_new RUNNING 0         -      10.0.3.226 -    false
```

### Container's snapshot

```
lxc-snapshot -n ubuntu_lxc (Note: You must stop a container before copy it for a new one.)
lxc-snapshot -L -n ubuntu_lxc
lxc-snapshot -r snap0 -n ubuntu_lxc
```

Examples:

```
betty@ubuntu1804:~# lxc-snapshot -n ubuntu_lxc
betty@ubuntu1804:~# lxc-snapshot -L  -n ubuntu_lxc
No snapshots
betty@ubuntu1804:~# lxc-ls
ubuntu_lxc     ubuntu_lxc_new
betty@ubuntu1804:~# lxc-ls -f
NAME           STATE   AUTOSTART GROUPS IPV4       IPV6 UNPRIVILEGED
ubuntu_lxc     RUNNING 0         -      10.0.3.178 -    false
ubuntu_lxc_new RUNNING 0         -      10.0.3.226 -    false
betty@ubuntu1804:~# lxc-stop -n ubuntu_lxc
betty@ubuntu1804:~# lxc-ls -f
NAME           STATE   AUTOSTART GROUPS IPV4       IPV6 UNPRIVILEGED
ubuntu_lxc     STOPPED 0         -      -          -    false
ubuntu_lxc_new RUNNING 0         -      10.0.3.226 -    false
betty@ubuntu1804:~# lxc-snapshot -n ubuntu_lxc
betty@ubuntu1804:~# lxc-snapshot -L  -n ubuntu_lxc
snap0 (/var/lib/lxc/ubuntu_lxc/snaps) 2020:05:16 07:03:17
```
