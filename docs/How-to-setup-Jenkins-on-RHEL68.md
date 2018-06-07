### Prerequisites:
* Have a VM (or any host) play the Jenkins server role, with Internet connected.

### Get JDK8:
1) Visit this page to download JDK 8: 
* Go to: http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html
* Click "Accept License Agreement"
* Download this rpm:

     ```Linux x64   167.14 MB       jdk-8u171-linux-x64.rpm```
2) Upload this rpm package to your VM.

### Install JDK8
1) Login your VM, and cd to the folder which has the above jdk rpm file uploaded.
2) Install this jdk by:
```
    $ sudo rpm -ivh jdk-8u171-linux-x64.rpm
    Preparing...                ########################################### [100%]
    1:jdk1.8                    ########################################### [100%]
    Unpacking JAR files...
        tools.jar...
        plugin.jar...
        javaws.jar...
        deploy.jar...
        rt.jar...
        jsse.jar...
        charsets.jar...
        localedata.jar...
```
3) Create a symbolic link ('-s') for Java

     ```$ sudo ln -s /usr/java/latest ~/java```
4) Check your Java version by:

    ``` $ java -version```

### Install Jenkins
1) Installation:
```
    $ sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
    $ sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
    $ sudo yum install jenkins
        ...
        Installed:
          jenkins.noarch 0:2.126-1.1
          Complete!
```

2) Set Jenkins automatically run when boot your VM:

```
    $ sudo chkconfig jenkins on
```
3) Start Jenkins this time:

```
    $ sudo service jenkins start
```
4) Check Jenkins status:

```
    $ service jenkins status
    jenkins (pid  1698) is running...
```

### Configure Jenkins
1) Login Jenkins with any web browser:
    ```http://your-vm-ip:8080```

2) Unlock Jenkins.
Following the page instruction; copy the admin initial password from here:
    ```/var/lib/jenkins/secrets/initialAdminPassword```
    
Paste the password to your Jenkins page to unblock it.

3) Select ```"Install suggested plugins"```, and wait for all of them installed.
4) Follow the instructions to ```"Create First Admin User"```
5) Follow the instructions to ```"instance Jenkins"```.
