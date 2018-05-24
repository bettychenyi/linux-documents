Prerequisite:  all Linux machines use the same login user, for example: betty.

# There could be two scenarios
* A) From Linux A to access a remote Linux B; (see steps from 1 to 4)
* B) From Windows W to access a remote Linux B by PuTTY. (see step 6)
 
## Create keys
Let's use a normal user betty (but it also works for root) for example:

On Linux A, create rsa key pairs

	ssh-keygen -t rsa
	
After this, you will see two files created under /home/betty/.ssh:
* id_rsa  -> the private key

* id_rsa.pub  -> the public key
 
## Copy pub key to remote host
Then copy the public key file content to remote Linux B's file: /home/betty/.ssh/authorized_keys

	ssh betty@RemoteLinuxB mkdir -p .ssh   #create a folder .ssh on remote Linux B
	cat /home/betty/.ssh/id_rsa.pub | ssh betty@RemoteLinuxB 'cat >> .ssh/authorized_keys'   #copy the content of public key (.pub) from Linux A, to remote Linux B's authorized_keys file which is under remote Linux B's /home/betty/.ssh folder
 
## Set folder and file permission
Now it is the time to take care of the ownership or modes for ".ssh" folder and "authorized_keys" file from remote Linux B. 
Otherwise, ssh server (running on Remote Linux B) will reject your key and fall back to username/password keyboard-interactive login. (in this case, you can use below troubleshooting steps to see such errors if login failed) 

	ssh betty@10.0.0.7 'chmod 700 .ssh'   # run this command on Linux A, to execute the chmod command remotely on Linux B
	ssh betty@10.0.0.7 'chmod 600 .ssh/authorized_keys'   # run this command on Linux A, to execute the chmod command remotely on Linux B (otherwise, you will see this error on Remote Linux B if you run sshd with debug mode '-d': "Authentication refused: bad ownership or modes for file /home/betty/.ssh/authorized_keys")
After running above commands, you will see below .ssh folder ownership and authorized_keys file modes:

	drwx------. 2 betty betty    29 May 17 07:00 .ssh
	-rw-------. 1 betty betty   403 May 17 07:00 authorized_keys

## Test
Now you can test remote login to B with the private key from A:

	ssh betty@RemoteLinuxB 

## Troubleshooting
* From Linux A: you can run ssh with verbose log mode (‘-v’) and see what did your ssh client try;

* From Linux B: you can stop sshd then start it with debug mode (‘-d’) and see the debug message: 

	service ssh stop
	/usr/sbin/sshd -d

## How to config Windows putty.exe to use this?
Now scenario A above has been solved, then how about the scenario B (login from Windows W by PuTTY to login Linux B)?
* Copy the private key "id_rsa" to Windows;
* Run PuttyGen.exe and load this private key
* Then "Save private key" to save the private key as a *.ppk file
* Now you can run putty with specifying using this ppk private key: Connection > SSH > Auth > Browse
* Note: If Putty failed with "Network error: Connection refused" directly then that means sshd is not running on your remote Linux B. You can start it by running /usr/sbin/sshd

