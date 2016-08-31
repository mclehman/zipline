#zipline

This is a Perl/bash reimplementation of adamnemecek's zipline (with slight UI changes) that should work on more than just OS X. Again, pure bash would be better and less of a hassle to install, but at least Perl is a bit more portable than Swift.

Zipline allows you to select a directory higher up in your current path and switch to it without messing around with "cd ../../..".

##Installation

Move or put a symlink to zl.pl in your path as zipline and add the contents of zl.sh to your .bashrc/.bash_profile (or use whatever names you like, I'm not picky).

Note: the minimum required Perl version is v5.12.


![screenshot](https://raw.github.com/mclehman/zipline/master/screenshot.png)
