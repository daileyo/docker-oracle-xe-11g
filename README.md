docker-oracle-xe-11g
============================

Oracle Express Edition 11g Release 2 on Ubuntu 16.04 LTS


```
docker pull daileyo/docker-oracle-xe-11g
```

NOTE:  This image is based off of [wnameless/oracle-xe-11g](https://github.com/wnameless/docker-oracle-xe-11g), and [sath89/oracle-xe-11g](https://github.com/MaksymBilenko/docker-oracle-xe-11g).  


Run with 22 and 1521 ports opened:
```
docker run -d -p 49160:22 -p 49161:1521 daileyo/oracle-xe-11g
```

Run this, if you want the database to be connected remotely:
```
docker run -d -p 49160:22 -p 49161:1521 -e ORACLE_ALLOW_REMOTE=true daileyo/docker-oracle-xe-11g
```

Connect database with following setting:
```
hostname: localhost
port: 49161
sid: xe
username: system
password: oracle
```

Password for SYS & SYSTEM
```
oracle
```

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

