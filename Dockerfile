FROM ubuntu:16.04

COPY assets /assets
RUN /assets/setup.sh

ENV ORACLE_HOME /u01/app/oracle/product/11.2.0/xe \
    PATH $ORACLE_HOME/bin:$PATH \
    ORACLE_SID=XE

EXPOSE  1521 \
        8080

VOLUME ["/u01/app/oracle"]  

CMD /usr/sbin/startup.sh && /usr/sbin/sshd -D
