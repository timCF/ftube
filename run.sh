#!/bin/bash
echo "HOST $1"
echo "THREADS $2"
pushd ./fproxy > /dev/null
PROXYLIST=($( ./run.sh | sed "s/\[/ /g" | sed "s/\]/ /g" | sed "s/,/ /g" | sed "s/\"/'/g" ))
popd > /dev/null
for N in $(seq 1 $2)
do
	THISPROXY=${PROXYLIST[$RANDOM % ${#PROXYLIST[@]}]}
	echo "GOT PROXY $THISPROXY"
	slimerjs --proxy=$THISPROXY ./ftube.js $1 &
done
wait
sleep 5
