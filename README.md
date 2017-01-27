#docker-oracle-xe-11g
============================

Oracle Express Edition 11g Release 2 on Ubuntu 16.04 LTS


```
docker pull daileyo/docker-oracle-xe-11g
```

**NOTE:**  This image is based off of [wnameless/oracle-xe-11g](https://github.com/wnameless/docker-oracle-xe-11g), and [sath89/oracle-xe-11g](https://github.com/MaksymBilenko/docker-oracle-xe-11g).  

##How this differs from wnameless
* Allows for db configuration to be persisted after container stop/restart (*similar to sath89.*)
* Runs sql scripts as sys sysdba rather than system.

##How this differs from sath89
* Implements initialization script functionality from wnameless.
* Does not utilize size optimizations of sath89 project.
* Does not have additional configuration options from sath89 project.
* Allows for remote connection configuration.
* Allows ssh connectivity as implemented by wnameless project.
* Project structure is essentially identical to wnameless project.

##Project information

###Environment Variables and exposed ports
* **ORACLE_ALLOW_REMOTE**
* **SSH default container port:** 22
* **Oracale default connect container  port:** 1521

###Container access information
* **Users available by default:**
  * SYS
  * SYSTEM
* **Password(s) for users:** oracle
* **SSH login user:** root
* **SSH login password:** admin

To run with 22 and 1521 ports opened, expose the ports to the host with docker run's -p command. 

Example:
```
docker run -d -p 49160:22 -p 49161:1521 daileyo/oracle-xe-11g
```
The above example maps container port 22 to host port 49160, and container port 1521 to 49161.


Login by SSH
```
ssh root@localhost -p 49160
password: admin
```

To initialize/configure database, initialize a new volume at container runtime that maps to /docker-entrypoint-initdb.d of the container.  
Example:
```
docker run -v /opt/demo:docker-entrypoint-initdb.d daileyo/docker-oracle-xe-11g
```

