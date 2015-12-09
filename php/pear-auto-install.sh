#!/bin/bash
/usr/bin/expect <<EOF
set send_slow {1 .1}
set timeout -1   
 spawn php -q go-pear.phar
 expect "1-11, 'all' or Enter to continue:"
   sleep .1
 send -s -- "1\r"
 expect -exact "1\r"
   sleep .1
 send -s -- "/usr/local\r"
 expect -exact "/usr/local\r"
 expect "1-11, 'all' or Enter to continue:"
   sleep .1
 send -s -- "\r"
 expect -exact "\r"
 expect EOF
