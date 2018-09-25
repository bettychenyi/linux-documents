<H2> Prerequisite </H2>

  1) This manual is based on CentOS 7.4
  
  2) Check Python version by ```python --version```. We have to use Python 3.6+
  
    yum install epel-release
    yum install centos-release-scl
    yum install rh-python36-python rh-python36-python-devel rh-python36-PyYAML
    echo 'pathmunge /opt/rh/rh-python36/root/usr/bin' > /etc/profile.d/python36.sh
    ## If pip3.6 is not being recognized, then use its absolute path: 
    cd /opt/rh/rh-python36/root/usr/bin
    ./pip3.6
    ./pip3.6 install --upgrade pip
    ./pip3.6 install pyasn ## You may be asked to install gcc if compile error (gcc not found)
    yum install gcc
    ./pip3.6 install mitmproxy

Now mitmproxy should be installed. Try it with:

```./mitmproxy```

<H2> Normal mode </H2>

```./mitmproxy --set block_global=false```

<H3> Troubleshooting </H3>

  1) Use "watch -d -n 1 ss -lntu" to monitor the port (by default, mitmproxy open TCP port 8080)
  2) Use "tcpdump -i eth0 -nnvvXSs 1514 port 8080" to capture the traffic on this 8080 port
  3) Use "telnet <this_mitmproxy_ip> 8080" to try this port is really open for you to use
  
<H3> How-to-use? </H3> 

  1) On any of your computer (let's call it as "TestDriveComputer") which can reach out to this proxy 
  
  Note: if this proxy is being protected by firewall, then enable the traffix on this TCP 8080 port
  
  2) Set your TestDriveComputer to use this proxy. For example, if this TestDriveComputer is a Windows machine, then:
  
    a) go to Edge Browser
    b) Click "..." on the right-up corner, then click "Settings"
    c) "View Advanced Settings"
    d) "Open proxy settings"
    e) In the window opened:
      1) Enable "Use a proxy server"
      2) Address: put your CentOS 7.4 proxy's Public IP
      3) Port: 8080
      4) Check "Don't use the proxy server for local (intranet) addresses"
      5) Save
  3) From "TestDriveComputer", in the Edge browser, type "mitm.it". This is a https website. Now you should be able to see this HTTPS requests send to the mitmproxy proxy now.
  
<H2> Transparent proxy </H2>

<H3> Enable forwarding </H3>

    sysctl -w net.ipv4.ip_forward=1
    sysctl -w net.ipv6.conf.all.forwarding=1
    sysctl -w net.ipv4.conf.all.send_redirects=0

    iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j REDIRECT --to-port 8080
    iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 443 -j REDIRECT --to-port 8080
    ip6tables -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j REDIRECT --to-port 8080
    ip6tables -t nat -A PREROUTING -i eth0 -p tcp --dport 443 -j REDIRECT --to-port 8080
    ./mitmproxy --mode transparent --showhost
  
