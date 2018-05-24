# Settings to push commit back to github
## git clone the repo, such as 
	git clone https://github.com/bettychenyi/linux-test-automation 

## Switch remote url from https to ssh
	git remote set-url origin git@github.com:[your-user-name]/[your-repo].git
	for example:
	git remote set-url origin git@github.com:bettychenyi/linux-test-automation.git

## Setup your keys
* Generate your key on you local box by:
	ssh-keygen -t rsa
* Go to github.com; login with your username and password, then go to "Settings", "SSH and GPG keys", then add "New SSH key". Copy and put your public key (id_rsa.pub) to the textbox; Save it.

## Make your changes, then add it and commit it to you local repo
	do-some-code-change
	git add .
	git commit

## git push your commit to your github repo
	git push
