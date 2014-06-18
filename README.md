
DD TESTSUITE
============

This package contains a set of scripts which can be used to perform dd-based 
I/O tests. These tests will conduct simultaneous read and write requests in a 
ratio of 2:1 using 2GiB files by default.

First, in order to perform read tests an initial set of input files needs to be 
set up. The create_inputfiles.sh script does this. The usage is as follows:

create_inputfiles.sh <number of files>

The script doing the reads will pick one of these files at random. 
The idea is that initially a fairly large number of files are created that will 
be used for the read test. During the test, read processes will pick one of these 
files at random. We have selected a file size of 2GiB since this is a typical file 
size in use with our users. The total size of all of these files combined should 
be equal to or greater than 25 times the total amount of memory on the host where 
the test is run which gives an indication on how many files should be created. For 
example, using 2GiB files and having 32GiB of memory in the machine you would need 
400 files. This is to reduce the benefit of the filesystem buffer cache. The block 
size used by dd is chosen to be 128KiB. This is equal to the block size used storage 
software that is used. Both the block size as the file size are configurable in the
"config" file. 

During the write test a faily large number of files are written. At random a number 
between 1 and MAX_FILES is chosen and the file#number will be written. This is also 
to reduce file system buffer cache effects. The number of file MAX_FILES is 
configurable through the variable in the "config" file. The same holds for the file
size.

When the test starts, reads and writes will be started simultaneously in the ratio of 2:1. 
This is done by running the "start_test.sh" script. The amount of reads and writes is 
configurable with a commandline flag of the "start_test.sh" script. These read and write 
processes are running indefinitely and should eventually be stopped using the 
"stop_test.sh" script. However, the processes should be run over a sufficiently long 
period of time to get a accurate measurement. This is especially needed for writes which 
initially show a very high rate due to filesystem buffer cache effects. It is usually 
sufficient to let the processes continue for, say, a few hundred iterations of writes and 
reads. The "result.sh" script parses the output files and displays the throughput 
performance. This script can also be run during the test. When the variations in throughput 
become small the test can be stopped.

