aws-session-export.rb
======================

Small little script to dump an AWS session to your console so that you can
put it in your shell (`bash` assumed).

Usage
------

Clone, and put the script somewhere in your $PATH.

After you have ran a command that dumps a session in the `~/.aws/cli/cache`
directory, run the script. If you have multiple sessions, the script will
prompt you for the one that you want to use.

License
--------

MIT

Author
-------

Chris Marchesi <chrism@vancluevertech.com>
