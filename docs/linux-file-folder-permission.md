# Represent Permission

There are two ways to represent a file's permissions:
* Symbolically (using symbols like "r" for read, "w" for write, and "x" for execute) 

* With an octal numeric value (for example: 755, 700 or 600, etc).

## rwx (read, write, execute)
Show file permission settings by:
	ls -l 
The permission settings will be represented symbolically, which will look like the following example:
	-rwxr-xr-- 
There are ten symbols here. 
* The first dash ("-") means that this is a "regular" file, in other words, not a directory (or a device, or any other special kind of file).* The remaining nine symbols represent the permissions: rwxr-xr--. 

* These nine symbols are actually three sets of three symbols each, and represent the respective specific permissions, from left to right:
symbols	meaning:
```
	rwx	the file's owner may read, write, or execute this file as a process on the system.
	r-x	anyone in the file's group may read or execute this file, but not write to it.
	r--	anyone at all may read this file, but not write to it or execute its contents as a process.
```

## octal numeric value (4, 2, 1)
* The file creation mask can also be represented numerically, using octal values (the digits from 0 to 7). 

* Specifically, the numbers 1, 2, and 4 represent the following permissions:
```
	number	permission
	4	read
	2	write
	1	execute
```

For example：
* chmod 700 .ssh; means give ONLY current user 7 permission to .ssh folder (other user does not have any permission; you can see we set other user permission to 0). “7” means “4 + 2 + 1” (read + write + execute).

* 600 means: current user has 6 (4 + 2, or read + write); other users do not have any permission;

* 755 means: current user has 7 (4 + 2 + 1, or read + write + execute); other users have 5 (4 + 1, or read + execute).

