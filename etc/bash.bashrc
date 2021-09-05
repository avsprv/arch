#
# /etc/bash.bashrc
#

source /usr/share/doc/pkgfile/command-not-found.bash

export HISTCONTROL=ignoreboth:erasedups
shopt -u mailwarn
unset MAILCHECK

shopt -s histappend histreedit histverify

export HISTSIZE=10000
export HISTFILESIZE=20000

shopt -s checkwinsize
shopt -s cmdhist
shopt -s cdspell
shopt -s cdable_vars
shopt -s checkhash
shopt -s sourcepath
shopt -s no_empty_cmd_completion
shopt -s extglob

export HISTTIMEFORMAT="%h %d %H:%M:%S "
export HISTIGNORE='&:exit:pwd:cd*:cl:l[s,l,h]:ps:history*:pacman*:yay*:w:who*:top:htop:kill*:pkill*'

EC() {
	echo -e '\e[1;33m'code $?'\e[m'
}
trap EC ERR

cl() {
	local dir="$1"
	local dir="${dir:=$HOME}"
	if [[ -d "$dir" ]]; then
		cd "$dir" >/dev/null; ls
	else
		echo "bash: cl: $dir: Directory not found"
	fi
}

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ $DISPLAY ]] && shopt -s checkwinsize

PS1='[\u@\h \W]\$ '

case ${TERM} in
  xterm*|rxvt*|Eterm|aterm|kterm|gnome*)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'

    ;;
  screen*)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033_%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'
    ;;
esac

[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion
source /etc/profile.d/ps1.sh
