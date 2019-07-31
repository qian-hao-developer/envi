# man page
http://man.openbsd.org/OpenBSD-current/man1/tmux.1

# send command to all panel
prefix :
setw synchronize-panel on

# swap panel
prefix :
swap-panel -t <target-panel-num>

# refresh panel
prefix :
respawn-panel -k
## restart with current path
respawn-panel -k -c .
## window
respawn-window ...(as above)

# reload config
:source-file ~/.tmux.conf

# resize layout to equal size
prefix E

# swap window
## swap left for 5 windows
prefix :
swap-window -t -5
