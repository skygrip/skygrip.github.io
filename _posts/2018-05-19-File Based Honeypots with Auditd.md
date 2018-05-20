---
layout: post
title: File Based Honeypots with Auditd
date: 2018-05-19 09:00:00 +0000
feature-img: "assets/img/pexels/computer.jpeg"
thumbnail: "assets/img/pexels/computer.jpeg"
tags:
    - Honeypots
    - Linux
    - Security
    - Auditd
---
Honeypots are all the rage with them being a fantastic tool to quickly identify malicious activity from usual system activity. There are many kinds of honeypots, including honeypot ports (honeyports) and even entire honey networks (honeynet), however the one I want to talk about is honeypot files (honeyfiles).

Honeyfiles are files that can be placed on a filesystem that are designed to look entising, and when accessed trigger an auditd rule to let you know. An example could be putting a file called "passwords.txt" on the filesystem. Any attacker that gains access to the system is likely to want to know what that file contains.

We can start by creating some random files to put around the filesystem

    dd if=/dev/urandom of=/SQLBackup-2017-11-24.gzip bs=120334KB count=1 iflag=fullblock
    dd if=/dev/urandom of=/root/passwords_encrypted.txt bs=334KB count=1 iflag=fullblock
    dd if=/dev/urandom of=/opt/apache-db-preupgrade.db bs=162334KB count=1 iflag=fullblock

The content of the files don't matter, even touching the files will be enough to trigger an alert. However, providing some legitimate but useless data may servce to wase the time of the attacker, giving you more time to repond.

Next we need to ensure that auditd is installed and running, on CentOS this would be done through the following commands:

    yum install audit
    systemctl enable auditd
    systemctl start auditd

Next we create our custom rule files in auditd

    root@ironmoon ~ # vim /etc/audit/rules.d/70-honeyfiles.rules
    -w /SQLBackup-2017-11-24.gzip -p wra -k HONEYFILE_ACCESSS
    -w /root/passwords_encrypted.txt -p wra -k HONEYFILE_ACCESSS
    -w /opt/apache-db-preupgrade.db -p wra -k HONEYFILE_ACCESSS

In these rules "-w" means file followed by the filepath, and "-p wra" means trigger on file read, write, or attribute change. With the rule created we just need to make sure its imported and auditd reloads the configuration.

    root@ironmoon ~ # augenrules
    root@ironmoon ~ # pkill -HUP -P 1 auditd
    
Now when we even access the files we will get a triggered alert

root@ironmoon / # aureport -f

    File Report
    ===============================================
    # date time file syscall success exe auid event
    ===============================================
    1. 19/05/18 23:32:35 passwords_encrypted.txt 191 no /usr/bin/ls 1000 337
    2. 19/05/18 23:32:41 passwords_encrypted.txt 192 yes /usr/bin/stat 1000 340
    3. 19/05/18 23:36:17 passwords_encrypted.txt 191 no /usr/bin/ls 1000 341
    4. 19/05/18 23:36:21 SQLBackup-2017-11-24.gzip 191 no /usr/bin/ls 1000 342
    5. 19/05/18 23:38:26 SQLBackup-2017-11-24.gzip 191 no /usr/bin/ls 1000 343
    6. 19/05/18 23:38:26 SQLBackup-2017-11-24.gzip 192 yes /usr/bin/ls 1000 344
    7. 19/05/18 23:38:26 SQLBackup-2017-11-24.gzip 191 no /usr/bin/ls 1000 345
    8. 19/05/18 23:38:26 SQLBackup-2017-11-24.gzip 191 no /usr/bin/ls 1000 346

This allows us to see all the access to those files, but you may notice that you will recieve information about ALL access, including simply grabbing info about the file from the ls command, as a result some filtering is required.

Now when its collected at a network loging server you can set up alerts whenever any access to the file is attempted. If we wanted the auditd logs to be forwared to syslog to be included in system logs, you can do that with the following setting

    root@ironmoon ~ # vim /etc/audisp/plugins.d/syslog.conf
    active = yes


