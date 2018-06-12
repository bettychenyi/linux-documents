### Prerequisites:
* Have a VM (or any host) play the Jenkins server role, with Internet connected.
* Tested on RHEL 7.2.

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

### Configure Jenkins Server/"master"
1) Login Jenkins Server portal with any web browser:
    ```http://your-vm-ip:8080```

2) Unlock Jenkins.
Following the page instruction; copy the admin initial password from here:
    ```/var/lib/jenkins/secrets/initialAdminPassword```
    
Paste the password to your Jenkins page to unblock it.

3) Select ```"Install suggested plugins"```, and wait for all of them installed.
4) Follow the instructions to ```"Create First Admin User"```
5) Follow the instructions to ```"Instance Configurations"```.

### Configure a Jenkins Client/"slave"
* We can add another Linux VM as ```"slave"```. 
* "Slave" is a VM which can run the real script you defined in your Jenkins job.
* When User go to Jenkins server web portal, then this user can click a Jenkins job and run it (```"Build Now"``` or ```"Build with Parameters"``` (if your job has parameters defined)). Then Jenkins host will tell the Jenkins Slave to run that job.

Here, let's use the Jenkins Server itself as a slave (run the job on the same VM you have). Let's do this:
1) Install git on it, so that your Jenkins job can get latest automation code your git repo:
```
     sudo apt install git
```
2) Configure your Slave
     - GO to Jenkins Home Page;
     - ```"Manage Jenkins"```
     - ```"Manage Nodes"```
     - ```"New Node"```
          - Give a name to your node, for example: ```"my-slave-on-jenkins"```
          - Choose ```"Permanent Agent"```
          - ```"OK"``` to continue
          - Give a ```"Remote root directory"```, for example, ```"/tmp"```
          - ```"Usage"```: ```"Use this node as much as possible"```
          - ```"Launch method"```: ```"Launch slave agent via SSH"```
               - ```"Host"```: please put the IP of your Jenkins slave (here the slave is on the same VM of your Jenkins Server, then use the same IP Address)
               - ```"Credentials"```, please click ```"Add"``` then click ```"Jenkins"``` to add your username/password, or username/private key which can be used to access your Jenkins slave (here it is the same VM of your Jenkins server). Finish other fields and click ```"Add"``` to add the new credential. Then from ```"Credentials"```, select your new created credential.
               - ```"Host Key Verification Strategy"```: ```"Non verifying Verification Strategy"```
          - Click ```"Save"``` to save this node
     - You will see the new node you just added, is marked as a red cross. Click ```"Launch agent"``` and wait it to complete.
          - Monitor the output and see any failures. If your credential is incorrect, then go to ```"Jenkins Home Page" > "Credentials" > Click your credential name (the latter part, with **** in the string) > Click "Update" to update it > Click "Save" ``` to save your changes.

3) Now, you will see Jenkins slave is being connected. You will see nodes there: one for ```"master"``` and one for ```"my-slave-on-jenkins"```.

### Create Jenkins Job

A Jenkins ```"Job"``` is a set of definations to do something for you. For example:
1) Accept user to input some value as parameter;
2) Fetch source code from the git repo you specified;
3) Automatically run script you specified.
 
Let's see how to create a job in Jenkins to do something (run a script) for you:
 
1) Click ```"New Item"```, then give the name to this item, for example: "InterVM-Latency-Test"
2) Check ```"Restrict where this project can be run"```, and then put your Jenkins slave name here (for example, ```"my-slave-on-jenkins"``` node you created above). Ignore the yellow warning here.
3) ```"Source Code Management"```:
     - Select ```"Git"```, because your source code is managed by git repo;
     - Provide the ```Git URL```; if necessary, ```"Add" Credential``` to access that;
4) ```"Build Environment"```
      - ```"Add timestamps to the Console Output"```
5) ```"Build"```
     - ```"Add build step"```, then define what "Command" you want this Jenkins job to run. For example: "ifconfig", or "./myfolder/my-bash-script.sh"
     Note, when running this experimental job, Jenkins job may say "ifconfig: command not found"; then go back to here to update ifconfig to "/usr/sbin/ifconfig" (specify ifconfig's full path name).
6) ``` "Post-build Actions"```
     - Select ```"Archive the artifacts"```. You can specify what files need to be archived.
5) ``` Save``` your job

### Run your Jenkins Job
1) Go to Jenkins Home Page
2) Click your job name, then you will go to the *"Job Page"*. Click ```"Build Now"``` to ask Jenkins Server to start running your job.
3) You will see a list of ```"Build History"```. That list lists all of your job's execution history. The top one (with biggest ID number)  is the most recent one;
4) Click a history ID from the list, you will go to the *"Build Page"* . From this page, you will see:
     - The test log file if you script produces log file and your job has collected them.
     - Click the ```"Console Output"``` from the left side, and you will see the test execution log.
     
     
   
