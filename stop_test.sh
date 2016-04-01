#!/bin/bash
export PATH=/usr/local/bin:$PATH

pids=`ps -A | grep 'read\|write'|awk '{print$1}'`
kill -15 $pids 2>/dev/null

pids=`ps -A | grep dd |awk '{print$1}'`
kill -15 $pids 2>/dev/null
