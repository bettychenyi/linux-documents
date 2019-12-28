# How to configure Linux access with key only

## Scenario

For example, you have a linux virtual machine in cloud, which is called "my-cloud-vm", with IP of "168.10.10.10".
You want to configure this Linux machine can only be accessed with private key.

### 1. Create the keys.
Login to your cloud Linux machine by the initial username/password to create the public/private key pair.
You also can create this key pair on any other Linux machine with below steps.

#### 1) Generate the key pair

Login with ```betty```, then run this command:

```ssh-keygen -t rsa```

You will see that, under ```/home/betty```, there is a folder called ```.ssh``` created. 
There are 3 files under this ```.ssh``` folder:

* ```authorized_keys```  => the public keys which are authorized to access this host

* ```id_rsa```           => the private key

* ```id_rsa.pub```       => the public key

#### 2) Copy the public key to terget machine

Copy the content of the *public* key file (```id_rsa.pub```) to file ```authorized_keys``` on the target machine (here it is the "my-cloud-vm")
so that it allows the key access. Otherwise, the access with this key pair will be denied.

```cd /home/betty/.ssh```

```cat id_rsa.pub >> authorized_keys```

### 2. Login with the private key from Linux terminal

If you want to login this target VM from another terminal Linux machine (for example, "my-Linux-terminal"),
then copy the private key ("id_rsa") to it.
You also can rename this file to your name, for example: betty_id_rsa

Please check the file permission after it is copied. The file permission should be "600". 
If not the case, then run this command to change the key file permission:

```chmod 600 betty_id_rsa```

Now, we can access your remote cloud Linux machine ("my-cloud-vm") from your local terminal ("my-Linux-terminal") by the key:

```ssh -i betty_id_rsa betty@168.10.10.10```

### 3. Login with the private key from Windows terminal

Just copy the private key to a local folder in the Windows machine, for exmaple, create a new text file, then copy/paste the private key file content to it, 
then save it as "betty_id_rsa"

Open mobaxterm, configure it to login with the key:

1. ```Remote Host```: specify the target VM's IP, here it is "168.10.10.10"
2. ```Specify username```: here, we can use "betty"
3. In the ```"Advanced SSH settings"``` tab, check ```"User private key"```, then browser the local ssh private key file ("betty_id_rsa").

Now, we can launch this connection with key authentication.

### 4. Remove password authentication from the target linux machine.

Login the remote cloud VM, open "/etc/ssh/sshd_config" to disable password authentication:

```sudo vi /etc/ssh/sshd_config```

Then make sure ```PasswordAuthentication no```

Then save the sshd_config file and restart the sshd service:

```sudo service ssh restart```


