#!/bin/sh

addresses=$*

org2remind=~/bin/org2remind.pl
tmpCal=/tmp/tmpCal.$$
perl $org2remind ~/Dropbox/Documents/org/todo.org ~/Dropbox/Documents/org/media.org | remind -c - > $tmpCal

tmpfile=/tmp/tmpfile.$$
emacs -batch -l /home/charles/.emacs.d/init.el -eval '(org-batch-agenda " " org-agenda-files (quote ("~/Dropbox/Documents/org/todo.org" "~/Dropbox/Documents/org/media.org")))' > $tmpfile

current_time=`date`

header=`(echo "Daily agenda for $current_time:
"; cat $tmpCal; echo "
"; cat $tmpfile)`
footer=`echo "Script used to create this email:" | cat - $0`
#echo "Daily agenda for $current_time:
#" | cat - Dropbox/Documents/org/agenda.txt | mail -s "Daily Agenda - $current_time" cmacanka@gmail.com

echo "$header

$footer" | mail -s "Daily Agenda - $current_time" $addresses
