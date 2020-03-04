
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

function prompt {
    local CHAR="♥" ## ♥ ☆ ♬ ○ ♩ ● ♪ - Keeping some cool ASCII Characters for reference
    autoload -U colors && colors
    ## Here is where we actually export the PS1 Variable which stores the text for your prompt
    PS1="%{$fg[green]%}%(4~|%-1~/.../%2~|%~) %{$reset_color%}%{$fg[blue]%}// %{$reset_color%}% %{$fg[red]%}%{$CHAR%} > %{$reset_color%}% "
    PS2='> '
    PS4='+ '
}

prompt

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
