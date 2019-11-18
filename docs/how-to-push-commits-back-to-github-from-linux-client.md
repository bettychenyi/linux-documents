# Settings to push commit back to github
## git clone the repo, such as 
	git clone https://github.com/bettychenyi/linux-test-automation 

## Switch remote url from https to ssh
	git remote set-url origin git@github.com:[your-user-name]/[your-repo].git
	for example:
	git remote set-url origin git@github.com:bettychenyi/linux-test-automation.git

## git operations without authentication after git clone
	Provide the username and token in the https clone URL
	git clone https://bettychenyi:mytoken111drewfsdfrewt@my-org.visualstudio.com/DefaultCollection/my-team/_git/my-repo

## Setup your keys
* Generate your key on you local box by:
	ssh-keygen -t rsa
* Go to github.com; login with your username and password, then go to "Settings", "SSH and GPG keys", then add "New SSH key". Copy and put your public key (id_rsa.pub) to the textbox; Save it.

## Make your changes, then add it and commit it to you local repo
	do-some-code-change
	git add .
	git commit

## How to use git in RHEL 6.7
```
[bettychen@betty-rhel67-dev-1 betty]# git clone https://github.com/bettychenyi/linux-documents
Initialized empty Git repository in /home/betty/linux-documents/.git/
error:  while accessing https://github.com/bettychenyi/linux-documents/info/refs

fatal: HTTP request failed

```
* Solution: update nss, curl packages by:

```~$ yum update -y nss curl```

## How to discard your local change
	git checkout .

## How to revert your "git add" and keep changes for add again
	git reset <file>, or git reset

## How to revert to previous commit (and discard local changes)
	git reset --hard HEAD

## git push your commit to your github repo
	git push
	
## How to delete/remove/revert last published commit
	# git rebase -i HEAD~2
	-> <Delete the 2nd line, and save>
	-> Successfully rebased and updated refs/heads/master.
	# git push origin master --force
		
## How to changing author info of a patch
* Create a fresh, bare clone of your repository
```
	git clone --bare https://github.com/user/repo.git
	or: git clone --bare user@your-git-url/repo.git
	cd repo.git
```
* Copy and paste the script, replacing the following variables based on the information you gathered:
```
	#!/bin/sh

	git filter-branch --env-filter '
	OLD_EMAIL="another-email@live.com"
	CORRECT_NAME="Betty Chen"
	CORRECT_EMAIL="correct-email@live.com"
	if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
	then
	    export GIT_COMMITTER_NAME="$CORRECT_NAME"
	    export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
	fi
	if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
	then
	    export GIT_AUTHOR_NAME="$CORRECT_NAME"
	    export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
	fi
	' --tag-name-filter cat -- --branches --tags
```
* Run this script and check the git history again

* Push the corrected history back
```
	git push --force --tags origin 'refs/heads/*'
```

* Clean up the temporary clone:
```
	cd ..
	rm -rf repo.git
```

### Error when "Push the corrected history back"
```
	fatal: 'origin' does not appear to be a git repository
	fatal: The remote end hung up unexpectedly
```
Then fix it in this way:
```
	git remote -v
	git remote add origin user@your-git-url/repo.git
	git push --force --tags origin 'refs/heads/*'
```

