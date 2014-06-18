#!/bin/bash

. config

export PATH=/usr/local/bin:$PATH

tpr=0
for file in ioread*
do 
seconds=`cat $file | grep 'copied' | awk '{print $7}'`
bytes=$FILESIZE

i=0
ts=0
for s in $seconds
do 
   i=`expr $i + 1`
   ts=`python -c "print str($s+$ts)"`
done
t=`python -c "print str($i*$bytes/($ts*1024*1024))"`
echo "read: $t"
tpr=`python -c "print str($t+$tpr)"`
done

tpw=0
for file in iowrite*
do
seconds=`cat $file | grep 'copied' | awk '{print $7}'`
bytes=`cat $file | grep -m 1 'copied' | awk '{print $3}'`

i=0
ts=0
for s in $seconds
do 
   i=`expr $i + 1`
   ts=`python -c "print str($s+$ts)"`
done
t=`python -c "print str($i*$bytes/($ts*1024*1024))"`
echo write: $t
tpw=`python -c "print str($t+$tpw)"`
done

echo avg throughput reads: $tpr MiB/s
echo avg throughput writes: $tpw MiB/s
echo
echo sum: `python -c "print str($tpr+$tpw)"` MiB/s
