#!/bin/bash
while true; do
	echo "HOST $1"
	echo "THREADS $2"
	pushd ./fproxy > /dev/null
	PROXYLIST=($( ./run.sh | sed "s/\[/ /g" | sed "s/\]/ /g" | sed "s/,/ /g" | sed "s/\"/'/g" ))
	popd > /dev/null
	for N in $(seq 1 $2)
	do
		THISPROXY=${PROXYLIST[$RANDOM % ${#PROXYLIST[@]}]}
		echo "$N THREAD GOT PROXY $THISPROXY"
		phantomjs --proxy=$THISPROXY ./ftube.js $1 &
	done
	echo "wait ..."
	wait
	echo "done ..."
	sleep 5
done
