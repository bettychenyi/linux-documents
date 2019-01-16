# ansible

### Introduction
```ansible``` is a IT tool widely used by many automation scenarios. 
The magic thing of ansible is that - it is ```agent-less``` framework. 
In another word, Ansible does not need to install any kind of additional agent on the target clients.

### How does this work? 

Ansible uses **standard ssh protocols** for server/client communication. 

### Terms in ansible

```Controlling machine```: the machine with ansible installed

```Host/node```: the clients in the cluster will be managed by ansible

### ansible host list

Ansible hosts will be defined in this file : ```/etc/ansible/inventory/hosts```

We also can use this ansible command to list the hosts: ```ansible --list-hosts *my_node*```

### Running some basic ansible commands

```
# ping all hosts:
ansible -m ping all
```

You may see some errors like this:

```
my_node_01 | UNREACHABLE! => {
    "changed": false,
    "msg": "Failed to connect to the host via ssh: Permission denied (publickey,gssapi-keyex,gssapi-with-mic,password).\r\n",
    "unreachable": true
}
```

Don't worry - the error message indicates that Ansible controlling machine is not able to access the host node. 
If public/private key authentication is not configured, 
you may need to add password in the host file: ```/etc/ansible/inventory/hosts```, like this:

```
ansible_gd1_server ansible_host=192.168.1.139 ansible_user=root ansible_ssh_pass=Password01
```

# ansible-playbook

### What is the ansible-playbook

```ansible-playbook``` is a ```YAML``` file which defines what tasks should be executed on what host.
So, if we want to do complex tasks on host nodes; or run different tasks on different host nodes, 
then we need to define those details (what tasks, and for what host nodes) into this ```YAML``` playbook file, 
then use ```ansible-playbook``` to run this ```YAML``` playbook file.

### How to use ansible-playbook

Below is an example of the YAML playbook file (```file-copy.yml```):

```
- hosts: my_node_01
  tasks:
     - copy:
         src: /root/bettychen/ansible/client-20180801.tar.gz
         dest: /root
     - copy:
         src: /root/bettychen/ansible/file.tar.gz
         dest: /root
     - copy:
         src: /root/bettychen/ansible/installer.ksh
         dest: /root
         owner: root
         mode: 0755
     - copy:
         src: /root/bettychen/ansible/scripts.tar
         dest: /root
```

Another example:

```
- hosts: my_node_02
  tasks:
     - name: Copy all files
       copy: src={{ item }} dest=/root
       with_fileglob:
         - /root/bettychen/ansible/*

```

Then let's use ```ansible-playbook``` to run it, like this:

```
ansible-playbook file-copy.yml --verbose
```




