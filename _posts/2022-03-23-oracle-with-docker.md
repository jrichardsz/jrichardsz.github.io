---
layout: post
title: Oracle with docker
description: "how to build and start an oracle express with docker"
category: devops
tags: [docker]
comments: true
---

Was a pain but at the end I was the winner. Here are the steps to build and start an oracle express 11 with docker


## Step1

**Download the Oracle Database Linux Binary**

Your first step is to download the Download the Oracle **Express Edition** version 18c (xe) Linux rpm from oracle.com. Oracle's docker files do support other editions, but the Express Edition is sufficient for getting started.

Just 11 and 18 version are downloadables:

https://www.oracle.com/database/technologies/oracle-database-software-downloads.html

![https://i.ibb.co/6vnVLgn/2021-01-25-09-36.png](https://i.ibb.co/6vnVLgn/2021-01-25-09-36.png)

### Step2

Clonar official repository

    git clone https://github.com/oracle/docker-images.git

### Step3

Copy zip file from oracle download into cloned repository

- This is the downloaded file from oracle oracle-xe-11.2.0-1.0.x86_64.rpm.zip
- Inside of it there is a folder called Disk1
- Inside of it, there is a file oracle-xe-11.2.0-1.0.x86_64.rpm
- Copy this file to /my/git/repos/docker-images/OracleDatabase/SingleInstance/dockerfiles/11.2.0.2

![https://i.ibb.co/ZT6YC8y/2021-01-25-09-38.png](https://i.ibb.co/ZT6YC8y/2021-01-25-09-38.png)


### Step4

Go to ../OracleDatabase/SingleInstance/dockerfiles and build with your version

    ./buildContainerImage.sh -x -v 11.2.0.2

If no errors, you will have a new docker image: oracle/database:11.2.0.2-xe

### Step5

Run. At this point I tried several ways and just this worked for me:

```
docker run --name oracle \
--shm-size=1g -p 1521:1521 \
-e ORACLE_SID=XE \
-e ORACLE_PWD=changeme \
-e ORACLE_PDB=changeme \
-v /tmp/oracle/oradata:/opt/oracle/oradata \
-v /tmp/data-bridge:/data-bridge \
-v /tmp/initscripts:/u01/app/oracle/scripts/startup \
oracle/database:11.2.0.2-xe
```

If no errors, go to next step.

### Step 6

Wait about 5 minutes to a complete start. Log should looks like this:


```
ORACLE PASSWORD FOR SYS AND SYSTEM: changeme

Oracle Database 11g Express Edition Configuration
-------------------------------------------------
This will configure on-boot properties of Oracle Database 11g Express
Edition.  The following questions will determine whether the database should
be starting upon system boot, the ports it will use, and the passwords that
will be used for database accounts.  Press <Enter> to accept the defaults.
Ctrl-C will abort.

Specify the HTTP port that will be used for Oracle Application Express [8080]:
Specify a port that will be used for the database listener [1521]:
Specify a password to be used for database accounts.  Note that the same
password will be used for SYS and SYSTEM.  Oracle recommends the use of
different passwords for each database account.  This can be done after
initial configuration:
Confirm the password:

Do you want Oracle Database 11g Express Edition to be started on boot (y/n) [y]:

Starting Oracle Net Listener...Done



Configuring database...Done
Starting Oracle Database 11g Express Edition instance...Done
Installation completed successfully.

SQL*Plus: Release 11.2.0.2.0 Production on Mon Jul 5 21:46:57 2021

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 11g Express Edition Release 11.2.0.2.0 - 64bit Production

SQL>
PL/SQL procedure successfully completed.

SQL> SQL>
Database altered.

SQL>
Database altered.

SQL>
Database altered.

SQL>
System altered.

SQL>
System altered.

SQL>
System altered.

SQL>
Database altered.

SQL>
Database altered.

SQL> SQL>
System altered.

SQL> Disconnected from Oracle Database 11g Express Edition Release 11.2.0.2.0 - 64bit Production
#########################
DATABASE IS READY TO USE!
#########################
The following output is now a tail of the alert.log:
  Current log# 5 seq# 4 mem# 0: /u01/app/oracle/oradata/XE/redo05.log
      ALTER DATABASE DROP LOGFILE GROUP 1
Deleted Oracle managed file /u01/app/oracle/fast_recovery_area/XE/onlinelog/o1_mf_1_jg6zcwgm_.log
Completed:       ALTER DATABASE DROP LOGFILE GROUP 1
      ALTER DATABASE DROP LOGFILE GROUP 2
Deleted Oracle managed file /u01/app/oracle/fast_recovery_area/XE/onlinelog/o1_mf_2_jg6zcyn3_.log
Completed:       ALTER DATABASE DROP LOGFILE GROUP 2
Cleared LOG_ARCHIVE_DEST_1 parameter default value
Using LOG_ARCHIVE_DEST_1 parameter default value as /u01/app/oracle/product/11.2.0/xe/dbs/arch
ALTER SYSTEM SET db_recovery_file_dest='' SCOPE=BOTH;
```

# step 7

If your container is running wihtou errors and your log is equal to the previous steps, you can now access to your new oracle!!

I dont know why but ORACLE_SID=acme is not taked. It is Oracle :|

This is the only parameters that worked for me:

ip: my.ip.foo.bar
port: 1521
user:system
password: changeme
sid/service_name: xe

![https://i.ibb.co/Jkjvkdm/2021-01-25-09-45.png](https://i.ibb.co/Jkjvkdm/2021-01-25-09-45.png)

As I connect as system user, I hope to be the god in this database and create anythink I want.


## Notes

https://github.com/oracle/docker-images/issues/670
https://github.com/oracle/docker-images/issues/525

## Extra: enable utl_file

docker exec -ti oracle sqlplus SYS/changeme@//192.168.666.666:1521/XE AS SYSDBA
grant execute on utl_file to system;

## common errors

- WARNING: No swap limit support
http://www.databusters.eu/2017/03/01/docker-linux-warning-no-swap-limit-support/

## Sources

- https://gist.github.com/cdivilly/8082bece0ad8f819a6b4a3630699ed46
- https://www.petefreitag.com/item/886.cfm
- https://stackoverflow.com/questions/45554498/how-do-i-connect-to-docker-oracle-instance/56979093
