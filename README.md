daily-agenda
============

This is a simple script that I use to email myself an agenda each morning.  Right now various parts are tailored to my own needs and setup, such as using paths and files which only make sense for me and my computers.  I would like to ultimately generalize the script enough so other people could easily use it, and also so I can tweak it or move it to another machine/setup easily.

I am a heavy user of [Org mode](http://orgmode.org/) for [Emacs](http://www.gnu.org/software/emacs/) to keep track of my projects and tasks.  But, I can sometimes forget to check my org files and get off track.  I seem to always be checking my email, so, I figure that if I can get my upcoming tasks into my email, I will be more likely to stay focused and remember what I should be doing (to put it dramatically).

I will eagerly say that this script is probably not well written, but it gets the job done, and I can clean it up later.  It hacks together several other tools, which means I can rest on quite a few shoulders of giants, but also means that this script has a fairly large number of disparate requirements.

Requirements
============

This script is just a single shell file, and does not automatically install any dependencies, so these all need to already be available or installed manually.  Sorry.

  * [Ruby](https://www.ruby-lang.org/), version 1.9 (possibly).
  * [ical2rem.rb](https://github.com/courts/ical2rem.rb) ruby gem.  This has its own dependencies on other gems.  Since this creates a binary when installed, ruby itself might not be needed to run it.  I already had ruby installed, so I never tested it.
  * [Emacs](http://www.gnu.org/software/emacs/)
  * [Org mode](http://orgmode.org/) for Emacs, which is distributed with Emacs.
  * [Perl](http://www.perl.org/), in order to run org2remind.pl.
  * [org2remind.pl](http://orgmode.org/worg/code/perl/org2remind.pl), which, as its name suggests, takes an org file and outputs a remind file with all of its events.  See more information about this script [here](http://orgmode.org/worg/org-tools/index.html#sec-2-14).
  * [remind](http://www.roaringpenguin.com/products/remind), to take the output of ial2rem.rb and org2remind.pl and create a fancy calendar.

Installation
============

This script does not need to be installed, per se.  It just needs to be run.  I have added it to my crontab, where it runs at 4:00am:

    00 4 * * * /usr/local/bin/send-daily-agenda.sh my-email@location.com

The file being referenced there is actually a symbolic link that points to the script inside my home directory.  The script looks to a file named "calendar_list" for URLs of Google calendars to download.  Right now, that file needs to be in the same directory as the script.

Usage
=====

Right now, there is not much customization with this script.  Simply add email addresses that the script should be sent to as arguments.

Overview
========

This script takes a set of org files and Google calendars, extracts their events, and creates a remind-formatted calendar.  It also creates an agenda with org mode from a set of org files.  The calendar and agenda are put into an HTML-formatted email and sent out.
