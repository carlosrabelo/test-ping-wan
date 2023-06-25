#!/bin/sh

ENDERECOS="10.0.0.1"
INTERFACE="em0"
CONTADOR=0

while [ $CONTADOR -le 2 ]
do
    for ENDERECO in $ENDERECOS
    do
	ping -c1 $ENDERECO >/dev/null 2>/dev/null
	if [ $? -eq 0 ]
	then
	    exit 0
	fi
    done

    if [ $CONTADOR -le 1 ]
    then
	/sbin/ifconfig $INTERFACE down
	sleep 5
	/sbin/ifconfig $INTERFACE up
	sleep 5
    else
	/sbin/shutdown -r now >/dev/null 2>/dev/null
	exit 1
    fi

    CONTADOR=`expr $CONTADOR + 1`
done
