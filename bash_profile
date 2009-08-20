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