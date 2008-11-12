test -r /sw/bin/init.sh && . /sw/bin/init.sh
export PATH="/usr/local/bin:/usr/local/sbin:$PATH:/opt/local/bin:/usr/local/mysql/bin"
export MANPATH="$MANPATH:/opt/local/share/man"
export INFOPATH="$INFOPATH:/opt/local/share/info"
export LC_CTYPE=en_US.UTF-8
export EDITOR='mate -w'
export SVN_EDITOR='mate -w'
alias ls="ls -laG"