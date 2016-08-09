#!/bin/bash

. config

IF=/dev/zero
OF=/dev/null

. config

seq () {
    i=$1
    s=""
    while [ $i -le $2 ]
    do
        s=$s"$i "
        i=`expr $i + 1`
    done
    echo $s
}

COUNT=`expr $FILESIZE \/ $BS`

mkdir -p $READDIR

usage () {
    echo "create_inputfile.sh <number of files>" 1>&2
}

if [ $# -ne 1 ]; then
   usage
   exit 1
fi

nfiles=$1

for i in `seq 1 ${nfiles}`
do

echo "write: dd if=$IF of=$READDIR/file$i bs=$BS count=$COUNT &"
dd if=$IF of=$READDIR/file$i bs=$BS count=$COUNT 2>&1 | sed -e "s/^/write $i: /" &
wait

done
