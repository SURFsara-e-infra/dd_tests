#!/bin/bash
. config
OF=/dev/null

. config

MiB=1048576

size=`ls -l $READDIR/file1 | awk '{print $5}'`
size_MiB=`python -c "print float($size)/$MiB"`

trap 'exit 0;' INT
trap 'exit 0;' TERM

nfiles=`ls -1 $READDIR/file* | wc -l`

i=0
while [ 1 ]
do
i=`expr $i + 1`
a=`expr ${RANDOM} \* ${nfiles}`
b=`expr $a / 32768`
c=`expr $b + 1`

echo "read $i: dd if=$READDIR/file$c of=$OF bs=$BS"
t0=`python -c "import time; print time.time()"`
dd if=$READDIR/file$c of=$OF bs=$BS
t1=`python -c "import time; print time.time()"`
seconds=`python -c "print $t1 - $t0"`
rate=`python -c "print $size_MiB/$seconds"`
echo read ${i}: $size bytes copied in $seconds seconds, $rate MiB/s

done
