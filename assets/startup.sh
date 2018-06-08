#!/bin/bash
LISTENER_ORA=/u01/app/oracle/product/11.2.0/xe/network/admin/listener.ora
TNSNAMES_ORA=/u01/app/oracle/product/11.2.0/xe/network/admin/tnsnames.ora

function loop_files {
	for f in $1/*; do
		case "$f" in
			*.sh)   echo "$0: running $f"; . "$f";;
			*.sql)	echo "$0: running $f"
							echo "exit" | /u01/app/oracle/product/11.2.0/xe/bin/sqlplus "SYS/oracle as sysdba" @"$f";;
			*)      echo "$0: ignoring $f" ;;
		esac
		echo
	done
}

cp "${LISTENER_ORA}.tmpl" "$LISTENER_ORA" &&
sed -i "s/%hostname%/$HOSTNAME/g" "${LISTENER_ORA}" &&
sed -i "s/%port%/1521/g" "${LISTENER_ORA}" &&
cp "${TNSNAMES_ORA}.tmpl" "$TNSNAMES_ORA" &&
sed -i "s/%hostname%/$HOSTNAME/g" "${TNSNAMES_ORA}" &&
sed -i "s/%port%/1521/g" "${TNSNAMES_ORA}" &&

service oracle-xe start


if [ "$ORACLE_ALLOW_REMOTE" = true ]; then
  echo "alter system disable restricted session;" | sqlplus -s SYSTEM/oracle
fi

if [ -d "/docker-entrypoint-initdb.d/setup" ]; then 
	printf \
"\n**************************************************\n \
Thisis the first time the container has been ran.\n \
Running one time configurtion.\n"

	loop_files "/docker-entrypoint-initdb.d/setup"
	mv /docker-entrypoint-initdb.d/setup ~/setup-debug
	rm -rf /docker-entrypoint-initdb.d/setup
printf "\n**************************************************\n"
fi

loop_files "/docker-entrypoint-initdb.d/startup"






