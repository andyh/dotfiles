source ~/.bash/config
source ~/.bash/aliases
source ~/.bash/paths
source ~/.bash/completions
 
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi
 
if [ -f ~/.localrc ]; then
  . ~/.localrc
fi

# if [[ -s /Users/andy/.rvm/scripts/rvm ]] ; then source /Users/andy/.rvm/scripts/rvm ; fi

# RVM should be loaded last after all path loads,etc
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.