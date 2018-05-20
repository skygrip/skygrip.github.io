---
layout: post
title: 'File Tarpits: Potential Linux Filesystem Tricks to Frustrate Attackers'
date: 2018-05-20 13:00:00 +1000
feature-img: "assets/img/pexels/computer.jpeg"
thumbnail: "assets/img/pexels/computer.jpeg"
tags:
    - Honeypots
    - Linux
    - Security
---

In the [previous post]({{ site.baseurl }}{% post_url 2018-05-19-File Based Honeypots with Auditd %}) we lernt about the power of file honeypots to detect malicious activity. But in this world of automation the time it takes for you to respond may be so long that its unlikely you can respond in time. In this post we will discuss some potential tactics to make your linux systems frustating to attackers who already have access and slow them down using some linux filesystem tricks.

Fitting 24GB of data onto a 10GB filesystem with Hardlinks
=============================================

Hardlinks permit you to copy files without consuming disk space, this can be useful for all kind of resons, but in this case we want to slow down attackers attempts to exfiltrate data. We can do this by creating fake data and artifically inflating the space on the disk that an attacker would want to exfiltrate, giving us a better change of responding in time.

First we will create a filesystem to do testing in because we don't want to corrupt our root file system

    cd /mnt
    dd if=/dev/zero of=ext4.img bs=1M count=10000
    mkfs.ext4 ext4.img
    mkdir tarpit
    mount ext4.img tarpit
    cd tarpit

Now we can create some dummy files and try to copy it with hardlinks

    dd if=/dev/urandom of=sql1_backup.gzip bs=4650MB count=1 iflag=fullblock
    dd if=/dev/urandom of=sql1_backuplogs.gzip bs=1650MB count=1 iflag=fullblock
    cp -l sql1_backup.gzip sql2_backup.gzip
    cp -l sql1_backuplogs.gzip sql2_backuplogs.gzip
    cp -l sql1_backup.gzip sql3_backup.gzip
    cp -l sql1_backuplogs.gzip sql3_backuplogs.gzip
    
    mkdir personal
    cp -l sql1_backup.gzip personal/dropbox_backup2018.gzip
    cp -l sql1_backuplogs.gzip personal/dropbox_backup2017.gzip

Let's check out how much space we are now consuming

    root@ironmoon /mnt/tarpit # tree -h
    .
    ├── [ 16K]  lost+found
    ├── [4.0K]  personal
    │   ├── [1.5G]  dropbox_backup2017.gzip
    │   └── [4.3G]  dropbox_backup2018.gzip
    ├── [4.3G]  sql1_backup.gzip
    ├── [1.5G]  sql1_backuplogs.gzip
    ├── [4.3G]  sql2_backup.gzip
    ├── [1.5G]  sql2_backuplogs.gzip
    ├── [4.3G]  sql3_backup.gzip
    └── [1.5G]  sql3_backuplogs.gzip
    
    root@ironmoon /mnt/tarpit # du -ah 
    4.4G	./sql2_backup.gzip
    16K	./lost+found
    1.6G	./sql3_backuplogs.gzip
    4.0K	./personal
    5.9G	.
    root@ironmoon /mnt/tarpit # du -ahl
    4.4G	./sql2_backup.gzip
    16K	./lost+found
    4.4G	./sql1_backup.gzip
    1.6G	./sql3_backuplogs.gzip
    1.6G	./personal/dropbox_backup2017.gzip
    4.4G	./personal/dropbox_backup2018.gzip
    5.9G	./personal
    4.4G	./sql3_backup.gzip
    1.6G	./sql2_backuplogs.gzip
    1.6G	./sql1_backuplogs.gzip
    24G	.

The du command has only listed and counted the files once, only when we tell it to include hardlinks does it count it like we want it to! Applications like du know about hardlinks and check for them. However, we can fool du into not throughly checking for hardlinks by modifying the inode link count on the files. This link count is incremented every time a file is linked to an inode, and decreased every time a file linked to an inode is deleted. Setting this field to 1 can hide the fact that there are other files sharing this inode. We can't do this normally, but we can do this by using filesystem debugging tools.

    root@ironmoon /mnt/tarpit # debugfs -wR 'mi sql1_backup.gzip' ../ext4.img
    debugfs 1.44.2 (14-May-2018)
                          Mode    [0100644] 
                       User ID    [0] 
                      Group ID    [0] 
                          Size    [1650000000] 
                 Creation time    [1526812651] 
             Modification time    [1526812650] 
                   Access time    [1526812643] 
                 Deletion time    [0] 
                    Link count    [2] 1
              Block count high    [0] 
                   Block count    [3222672] 
                    File flags    [0x80000] 
                    Generation    [0x2a1a1192] 
                      File acl    [0] 
           High 32bits of size    [0] 
              Fragment address    [0] 
               Direct Block #0    [127754] 
               Direct Block #1    [65540] 
               Direct Block #2    [0] 
               Direct Block #3    [0] 
               Direct Block #4    [33795] 
               Direct Block #5    [0] 
               Direct Block #6    [32768] 
               Direct Block #7    [30720] 
               Direct Block #8    [67584] 
               Direct Block #9    [63488] 
              Direct Block #10    [32768] 
              Direct Block #11    [100352] 
                Indirect Block    [96256] 
         Double Indirect Block    [30720] 
         Triple Indirect Block    [133120] 

We need to remount the filesystem before this change will take effect.

    root@ironmoon /mnt # cd .. && umount tarpit && mount ext4.img tarpit && cd tarpit
    root@ironmoon /mnt # du -ah 
    4.4G	./tarpit/sql2_backup.gzip
    16K	./tarpit/lost+found
    4.4G	./tarpit/sql1_backup.gzip
    1.6G	./tarpit/sql3_backuplogs.gzip
    1.6G	./tarpit/personal/dropbox_backup2017.gzip
    4.4G	./tarpit/personal/dropbox_backup2018.gzip
    5.9G	./tarpit/personal
    4.4G	./tarpit/sql3_backup.gzip
    1.6G	./tarpit/sql2_backuplogs.gzip
    1.6G	./tarpit/sql1_backuplogs.gzip
    24G	./tarpit
    4.0K	./windows
    5.9G	./ext4.img
    30G	.

Now applications like du have a harder time detecting hardlinks, making it more likely that attackrs won't notice. However, doing this now means that we are technially running a "corrupt" filesystem, and fsck will alert of this

    root@ironmoon /mnt # fsck /dev/loop0 -fn
    fsck from util-linux 2.32
    e2fsck 1.44.2 (14-May-2018)
    Warning!  /dev/loop0 is mounted.
    Warning: skipping journal recovery because doing a read-only filesystem check.
    Pass 1: Checking inodes, blocks, and sizes
    Inode 129794 is in use, but has dtime set.  Fix? no
    
    Pass 2: Checking directory structure
    Pass 3: Checking directory connectivity
    Pass 4: Checking reference counts
    Inode 12 ref count is 1, should be 4.  Fix? no
    
    Inode 13 ref count is 1, should be 4.  Fix? no
    
    Unattached zero-length inode 129794.  Clear? no

    Unattached inode 129794
    Connect to /lost+found? no

    Pass 5: Checking group summary information
    Inode bitmap differences:  +129794
    Fix? no
    
    
    /dev/loop0: ********** WARNING: Filesystem still has errors **********

    /dev/loop0: 12/640848 files (0.0% non-contiguous), 468678/2560000 blocks

What's more if you or anyone else deletes any of the files, the inode link count will decrease to 0 causing the inode to be considered unallocated and causing all kinds of errors. You won't be able to fix it without manually setting the link count either, as running fsck will propt for the files to be deleted.

    root@ironmoon /mnt/tarpit # rm sql3_backup.gzip sql3_backuplogs.gzip
    root@ironmoon /mnt/tarpit # cd .. && umount tarpit && mount ext4.img tarpit && cd tarpit
    root@ironmoon /mnt/tarpit # ls                                                               :(
    ls: cannot access 'sql2_backup.gzip': Structure needs cleaning
    ls: cannot access 'sql1_backup.gzip': Structure needs cleaning
    ls: cannot access 'sql2_backuplogs.gzip': Structure needs cleaning
    ls: cannot access 'sql1_backuplogs.gzip': Structure needs cleaning
    lost+found  sql1_backup.gzip      sql2_backup.gzip
    personal    sql1_backuplogs.gzip  sql2_backuplogs.gzip
    root@ironmoon /mnt # fsck /dev/loop0 -fn                                                       :(
    fsck from util-linux 2.32
    e2fsck 1.44.2 (14-May-2018)
    Warning!  /dev/loop0 is mounted.
    Warning: skipping journal recovery because doing a read-only filesystem check.
    Pass 1: Checking inodes, blocks, and sizes
    Pass 2: Checking directory structure
    Entry 'sql1_backup.gzip' in / (2) has deleted/unused inode 12.  Clear? no
    
    Entry 'sql1_backuplogs.gzip' in / (2) has deleted/unused inode 13.  Clear? no
    
    Entry 'sql2_backup.gzip' in / (2) has deleted/unused inode 12.  Clear? no
    
    Entry 'sql2_backuplogs.gzip' in / (2) has deleted/unused inode 13.  Clear? no
    
    Entry 'dropbox_backup2018.gzip' in /personal (389377) has deleted/unused inode 12.  Clear? no
    
    Entry 'dropbox_backup2017.gzip' in /personal (389377) has deleted/unused inode 13.  Clear? no
        
    Pass 3: Checking directory connectivity
    Pass 4: Checking reference counts
    Pass 5: Checking group summary information
    
    /dev/loop0: ********** WARNING: Filesystem still has errors **********
    
    /dev/loop0: 12/640848 files (0.0% non-contiguous), 65845/2560000 blocks

In conclusion, you can create these file based tarpits to slow down attackers, but there isn't a "good" way to prevent an attacker from being able to work out what's going on with standard tools if they are paying attention. However, the cost of just having some files on the filesystem is often minimal, and it may very well slow down an attacker.

Infinitly recurring directories with Hardlinks
==============================================

What if we could have infinite dummy data through a recursive hardlink on a directoy! An attacker would spend forever copying the data off, that will slow them down significantly. Let's try to make it work.

We start by setting up a new filesystem as we broke the last one

    cd /mnt
    umount tarpit
    dd if=/dev/zero of=ext4.img bs=1M count=10000
    mkfs.ext4 ext4.img
    mkdir tarpit
    mount ext4.img tarpit
    cd tarpit

And fill it with a few files and folders to play with

    mkdir accounts
    dd if=/dev/urandom of=accounts/sql1_backup.gzip bs=650MB count=1 iflag=fullblock

The plan here is to have a folder in accounts link back on itself by creating a hard link. You can't hard link back to yourself in the same directory, but if you have a directory inbetween you can achieve the same thing.

    root@ironmoon /mnt/tarpit # mkdir accounts/2018/
    root@ironmoon /mnt/tarpit # cp -lr accounts accounts/2018/records
    cp: cannot copy a directory, 'accounts', into itself, 'accounts/2018/records'

The cp command knows what we are doing, and won't let us setup a hardlink. But what if we created the link anyway? Filesystem debug tools to the rescue!

    root@ironmoon /mnt/tarpit # debugfs -wR 'link accounts accounts/2018/records' ../ext4.img
    root@ironmoon /mnt/tarpit # cd .. && umount tarpit && mount ext4.img tarpit && cd tarpit
    root@ironmoon /mnt/tarpit # ls accounts                                                        :(
    ls: cannot access 'accounts/accounts': Structure needs cleaning
    2018  accounts  sql1_backup.gzip
    1 root@ironmoon /mnt/tarpit # tree accounts                                                      :(
    accounts
    ├── 2018
    └── sql1_backup.gzip
    root@ironmoon /mnt/tarpit # cp -r accounts ../test 
    cp: cannot stat 'accounts/accounts': Structure needs cleaning
    cp: cannot stat 'accounts/2018/records': Too many levels of symbolic links

In conculsion it works, but the tree command sees through the disguise and if the attacker tried to use cp to copy the files off, then cp would also see though the disguise. This causes a lot of erors too, and requires you to "corrupt" your file system. Frustrating but not practical.

Infinitly recurring directories with Softlinks
==============================================

Ok so hardlink recursive directories don't work, what about softlinks? Many software suites undersand softlinks and correctly honor them.

We start by setting up a new filesystem as we broke the last one

    cd /mnt
    umount tarpit
    dd if=/dev/zero of=ext4.img bs=1M count=10000
    mkfs.ext4 ext4.img
    mkdir tarpit
    mount ext4.img tarpit
    cd tarpit

And fill it with a few files and folders to play with

    mkdir accounts
    dd if=/dev/urandom of=accounts/sql1_backup.gzip bs=650MB count=1 iflag=fullblock
    
this time we use softlinks, with absoloute paths

    root@ironmoon /mnt/tarpit # ln -s /mnt/tarpit/ accounts/services/2018
    root@ironmoon /mnt/tarpit # tree
    .
    └── accounts
        ├── services
        │   └── 2018 -> /mnt/tarpit/
        └── sql1_backup.gzip
    
    3 directories, 1 file
    root@ironmoon /mnt/tarpit # du -hal
    620M	./accounts/sql1_backup.gzip
    0	./accounts/services/2018
    4.0K	./accounts/services
    620M	./accounts
    620M	.

The problem here is all our tools know what's going on here, they expect that a symbolic link loop may exist. The cp command knows that symbolic links exist and won't attempt to even copy their contents, but will just attempt to copy the symbolic link file.

Conclusions
==========

Filesystems are working like they should, they resist the ability for you to create any kind of loop condition, and it requires you to manually edit the filesystem to even fool them. While they may confuse any attacker that does gain access to your system, the only trick here that I would recomend is normal hardlink of dummy files.

Combining these honeyfiles and legal hardlinks makes for a legitimate strategy to catch and slow attackers down. And when its free with no software required to be installed, why not try it out?
