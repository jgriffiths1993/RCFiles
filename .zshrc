autoload -U compinit promptinit zcalc zsh-mime-setup colors
colors
compinit
promptinit
zsh-mime-setup

alias cdp='cd ~/Documents/Project'

# why would you type 'cd dir' if you could just type 'dir'?
setopt AUTO_CD

# Now we can pipe to multiple outputs!
setopt MULTIOS

# Spell check commands!  (Sometimes annoying)
setopt CORRECT

# This makes cd=pushd
setopt AUTO_PUSHD

# This will use named dirs when possible
setopt AUTO_NAME_DIRS

# If we have a glob this will expand it
setopt GLOB_COMPLETE
setopt PUSHD_MINUS

# No more annoying pushd messages...
setopt PUSHD_SILENT

# blank pushd goes to home
setopt PUSHD_TO_HOME

# use magic (this is default, but it can't hurt!)
setopt ZLE

setopt NO_HUP

setopt EMACS

# only fools wouldn't do this ;-)
export EDITOR="vim"

setopt IGNORE_EOF

# If I could disable Ctrl-s completely I would!
setopt NO_FLOW_CONTROL

# beeps are annoying
setopt NO_BEEP

# Keep echo "station" > station from clobbering station
setopt NO_CLOBBER

# Case insensitive globbing
setopt NO_CASE_GLOB

# Be Reasonable!
setopt NUMERIC_GLOB_SORT

# I don't know why I never set this before.
setopt EXTENDED_GLOB

# hows about arrays be awesome?  (that is, frew${cool}frew has frew surrounding all the variables, not just first and last
setopt RC_EXPAND_PARAM

#}}}

#{{{ Variables
export MATHPATH="$MANPATH:/usr/local/texlive/2007/texmf/doc/man"
export INFOPATH="$INFOPATH:/usr/local/texlive/2007/texmf/doc/info"
export PATH="$PATH:/usr/local/texlive/2007/bin/i386-linux"
export RI="--format ansi"

declare -U path

#export LANG=en_US
export PAGER=most

# Include stuff that should only be on this
if [[ -r ~/.localinclude ]]; then
    source ~/.localinclude
fi

# Include local directories
if [[ -r ~/.localdirs ]]; then
        source ~/.localdirs
fi

autoload run-help
HELPDIR=~/zsh_help

#{{{ Shell Conveniences

alias sz='source ~/.zshrc'
alias ez='vim ~/.zshrc'
alias mk=popd
alias ls='pwd; ls --color'

#{{{ Completion Stuff

bindkey -M viins '\C-i' complete-word
bindkey "^R" history-incremental-search-backward

# Faster! (?)
zstyle ':completion::complete:*' use-cache 1

# case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''
#zstyle ':completion:*' completer _oldlist _expand _force_rehash _complete
zstyle ':completion:*' completer _expand _force_rehash _complete _approximate _ignored

# generate descriptions with magic.
zstyle ':completion:*' auto-description 'specify: %d'

# Don't prompt for a huge list, page it!
zstyle ':completion:*:default' list-prompt '%S%M matches%s'

# Don't prompt for a huge list, menu it!
zstyle ':completion:*:default' menu 'select=0'

# Have the newer files last so I see them first
zstyle ':completion:*' file-sort modification reverse

# color code completion!!!!  Wohoo!
zstyle ':completion:*' list-colors "=(#b) #([0-9]#)*=36=31"

unsetopt LIST_AMBIGUOUS
setopt  COMPLETE_IN_WORD

# Separate man page sections.  Neat.
zstyle ':completion:*:manuals' separate-sections true

# Egomaniac!
zstyle ':completion:*' list-separator 'fREW'

# complete with a menu for xwindow ids
zstyle ':completion:*:windows' menu on=0
zstyle ':completion:*:expand:*' tag-order all-expansions

# more errors allowed for large words and fewer for small words
zstyle ':completion:*:approximate:*' max-errors 'reply=(  $((  ($#PREFIX+$#SUFFIX)/3  ))  )'

# Errors format
zstyle ':completion:*:corrections' format '%B%d (errors %e)%b'

# Don't complete stuff already on the line
zstyle ':completion::*:(rm|vi):*' ignore-line true

# Don't complete directory we are already in (../here)
zstyle ':completion:*' ignore-parents parent pwd

zstyle ':completion::approximate*:*' prefix-needed false

#}}}

#{{{ Key bindings

# Who doesn't want home and end to work?
bindkey '\e[H' beginning-of-line
bindkey '\e[F' end-of-line

# Incremental search is elite!
bindkey -M vicmd "/" history-incremental-search-backward
bindkey -M vicmd "?" history-incremental-search-forward

# Search based on what you typed in already
bindkey -M vicmd "//" history-beginning-search-backward
bindkey -M vicmd "??" history-beginning-search-forward

bindkey "\eOP" run-help

# oh wow!  This is killer...  try it!
bindkey -M vicmd "q" push-line

# Ensure that arrow keys work as they should
bindkey '\e[A' up-line-or-history
bindkey '\e[B' down-line-or-history

bindkey '\eOA' up-line-or-history
bindkey '\eOB' down-line-or-history

bindkey '\e[C' forward-char
bindkey '\e[D' backward-char

bindkey '\eOC' forward-char
bindkey '\eOD' backward-char

bindkey -M viins 'jj' vi-cmd-mode
bindkey -M vicmd 'u' undo

# Rebind the insert key.  I really can't stand what it currently does.
bindkey '\e[2~' overwrite-mode

# Rebind the delete key. Again, useless.
bindkey '\e[3~' delete-char

bindkey -M vicmd '!' edit-command-output

# it's like, space AND completion.  Gnarlbot.
bindkey -M viins ' ' magic-space

#}}}

#{{{ History Stuff

# Where it gets saved
HISTFILE=~/.history

# Remember about a years worth of history (AWESOME)
SAVEHIST=10000
HISTSIZE=10000

# Don't overwrite, append!
setopt APPEND_HISTORY

# Write after each command
setopt INC_APPEND_HISTORY

# Killer: share history between multiple shells
setopt SHARE_HISTORY

# If I type cd and then cd again, only save the last one
setopt HIST_IGNORE_DUPS

# Even if there are commands inbetween commands that are the same, still only save the last one
setopt HIST_IGNORE_ALL_DUPS

# Pretty    Obvious.  Right?
setopt HIST_REDUCE_BLANKS

# If a line starts with a space, don't save it.
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE

# When using a hist thing, make a newline show the change before executing it.
setopt HIST_VERIFY

# Save the time and how long a command ran
setopt EXTENDED_HISTORY

setopt HIST_SAVE_NO_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS

#}}}

#{{{ Prompt!
case "$TERM" in
  (screen)
    function precmd() { print -Pn "\033]0;S $TTY:t{%100<...<%~%<<}\007" }
  ;;
  (*)
    directory_prompt="%{$fg[$directory_color]%}%~%{$reset_color%} "
  ;;
esac

PROMPT="%T %# "
RPROMPT="[%3~][%n][%?]"

_force_rehash() {
  (( CURRENT == 1 )) && rehash
  return 1 
}

edit-command-output() {
 BUFFER=$(eval $BUFFER)
 CURSOR=0
}
zle -N edit-command-output

#}}}

watch=(notme)
LOGCHECK=0
#}}}

#{{{ ZSH Modules
autoload -U compinit promptinit zcalc zsh-mime-setup
compinit
promptinit
zsh-mime-setup
export PERL5LIB=~/perl5/lib/perl5
#}}}

[[ -s "~/.gvm/scripts/gvm" ]] && source "~/.gvm/scripts/gvm"
export GOPATH=$HOME/golang
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/lib

# Find files from the current directory
fh() {
    if [ -z "$@" ]; then
        echo "No args."
        return 1
    fi
    find ./ -iname "$@" 2>/dev/null
}

# Find files from here and open in vi
vif() {
    if [ -z "$@" ]
    then 
        echo "No args."
        return 1
    fi
    _files=`find ./ -iwholename "*$@" 2>/dev/null`
    if [ -z $_files ]; then
        echo "No matches."
        return 1
    else
        vi `echo $_files | tr '\n' ' '`
    fi
}
