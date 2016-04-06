#!/bin/bash
while true; do
	echo "HOST $1"
	echo "THREADS $2"
	if [ -z "$3" ]
	then
		echo "COUNTRY : ALL"
		COUNTRY=""
	else
		echo "COUNTRY : $3"
		COUNTRY="$3"
	fi
	pushd ./fproxy > /dev/null
	PROXYLIST=($( ./run.sh $COUNTRY | sed "s/\[/ /g" | sed "s/\]/ /g" | sed "s/,/ /g" | sed "s/\"/'/g" ))
	popd > /dev/null
	if [ "${#PROXYLIST[@]}" -ne "0" ]
	then
		for N in $(seq 1 $2)
		do
			THISPROXY=${PROXYLIST[$RANDOM % ${#PROXYLIST[@]}]}
			echo "$N THREAD GOT PROXY $THISPROXY"
			phantomjs --proxy=$THISPROXY ./ftube.js $1 &
		done
		echo "wait ..."
		wait
		echo "done ..."
	else
		echo "prevent division by zero ..."
	fi
	sleep 5
done
