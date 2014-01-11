#!/bin/sh

addresses=$*

org2remind=~/bin/org2remind.pl
tmpCal=/tmp/tmpCal.$$
perl $org2remind ~/Dropbox/Documents/org/todo.org ~/Dropbox/Documents/org/media.org | remind -c - > $tmpCal

tmpfile=/tmp/tmpfile.$$
emacs -batch -l /home/charles/.emacs.d/init.el -eval '(org-batch-agenda " " org-agenda-files (quote ("~/Dropbox/Documents/org/todo.org" "~/Dropbox/Documents/org/media.org")))' > $tmpfile

current_time=`date`

body=`(echo "Daily agenda for $current_time:";
echo '<pre style="font-family:Consolas,monospace;">'; cat $tmpCal; echo "
"; cat $tmpfile; echo "</pre>
Script used to create this email:<br />
(Currently disabled until the text can be properly escaped.)")`

echo "$body" | mail -a "MIME-Version: 1.0" -a "Content-Type: text/html" -s "Daily Agenda - $current_time" $addresses
