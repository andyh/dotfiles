_mategem()
{
    local curw
    COMPREPLY=()
    curw=${COMP_WORDS[COMP_CWORD]}
    local gems="$(gem environment gemdir)/gems"
    COMPREPLY=($(compgen -W '$(ls $gems)' -- $curw));
    return 0
}
complete -F _mategem -o dirnames mategem

function authme() {
	ssh $1 'cat >>.ssh/authorized_keys' <~/.ssh/id_rsa.pub
}

alias gl='git log --graph --pretty=format:"%Cred%h%Creset — %s %Cgreen(%cr)%Creset" --abbrev-commit --date=relative'