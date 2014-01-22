#!/bin/sh

addresses=$*

google_calendars=""
ical2rem="/usr/local/bin/ical2rem-cli"
temp_google_calendar=/tmp/temp_google_calendar.$$
while read -r line
do
    wget -q $line -O $temp_google_calendar
    curr_cal=`$ical2rem < $temp_google_calendar`
    google_calendars="$google_calendars
$curr_cal"
done < "/home/charles/projects/daily-agenda/calendar_list"

org2remind=/home/charles/bin/org2remind.pl
orgCal=`perl $org2remind ~/Dropbox/Documents/org/todo.org ~/Dropbox/Documents/org/media.org`
allCals=`echo "$orgCal
$google_calendars"`

tmpCal=/tmp/tmpCal.$$
echo "$allCals" | remind -c -w120 - > $tmpCal

tmpfile=/tmp/tmpfile.$$
emacs -batch -l /home/charles/.emacs.d/init.el -eval '(org-batch-agenda " " org-agenda-files (quote ("~/Dropbox/Documents/org/todo.org" "~/Dropbox/Documents/org/media.org")))' > $tmpfile

current_time=`date`

body=`(echo "Daily agenda for $current_time:";
echo '<pre style="font-family:Consolas,DejaVu Sans Mono,monospace;">'; cat $tmpCal; echo "
"; cat $tmpfile; echo "</pre>
Script used to create this email:<br />
(Currently disabled until the text can be properly escaped.)")`

echo "$body" | mail -a "MIME-Version: 1.0" -a "Content-Type: text/html" -s "Daily Agenda - $current_time" $addresses
