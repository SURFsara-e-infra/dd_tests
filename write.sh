#!/bin/bash
. config
WRITEDIR=${WRITEDIR}/testdir.$$
IF=/dev/zero
OF=/dev/null

COUNT=`expr $FILESIZE \/ $BS`

MiB=1048576

trap 'exit 0;' INT
trap 'exit 0;' TERM

mkdir -p $WRITEDIR
size=$FILESIZE
size_MiB=`python -c "print float($size)/$MiB"`

i=0
while [ 1 ]
do

i=`expr $i + 1`
a=`expr ${RANDOM} \* ${MAX_FILES}`
b=`expr $a / 32768`
c=`expr $b + 1`

echo "write $i: dd if=$IF of=$WRITEDIR/file$c bs=$BS count=$COUNT"
t0=`python -c "import time; print time.time()"`
dd if=$IF of=$WRITEDIR/file$c bs=$BS count=$COUNT
t1=`python -c "import time; print time.time()"`
seconds=`python -c "print $t1 - $t0"`
rate=`python -c "print $size_MiB/$seconds"`
echo write ${i}: $size bytes copied in $seconds seconds, $rate MiB/s
rm -f $WRITEDIR/file$c

done
