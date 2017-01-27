FROM ubuntu:16.04

MAINTAINER Daileyo (dale13@gmail.com)

ADD assets /assets
RUN /assets/setup.sh

ENV ORACLE_HOME /u01/app/oracle/product/11.2.0/xe 
ENV PATH $ORACLE_HOME/bin:$PATH 
ENV ORACLE_SID=XE

EXPOSE 1521
EXPOSE 8080

VOLUME ["/u01/app/oracle"]  

CMD /usr/sbin/startup.sh && /usr/sbin/sshd -D
