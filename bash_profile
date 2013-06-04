# Configuring Our Prompt
# ======================

  # This function is called in your prompt to output your active git branch.
  function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
  }

  # This function builds your prompt. It is called below
  function prompt {
    # Define some local colors
    local         RED="\[\033[0;31m\]" # This syntax is some weird bash color thing I never
    local   LIGHT_RED="\[\033[1;31m\]" # really understood
    local        CHAR="♥"
    # ♥ ☆ - Keeping some cool ASCII Characters for reference

    # Here is where we actually export the PS1 Variable which stores the text for your prompt
    export PS1="\[\e]2;\u@\h\a[\[\e[37;44;1m\]\t\[\e[0m\]]$RED\$(parse_git_branch) \[\e[32m\]\W\[\e[0m\]\n\[\e[0;31m\]♥ \[\e[0m\]"
      PS2='> '
      PS4='+ '
    }

  # Finally call the function and our prompt is all pretty
  prompt

  # For more prompt coolness, check out Halloween Bash:
  # http://xta.github.io/HalloweenBash/

  # If you break your prompt, just delete the last thing you did.
  # And that's why it's good to keep your dotfiles in git too.

# Environment Variables
# =====================
  # Library Paths
  # These variables tell your shell where they can find certain
  # required libraries so other programs can reliably call the variable name
  # instead of a hardcoded path.

    # NODE_PATH
    # Node Path from Homebrew I believe
    export NODE_PATH="/usr/local/lib/node_modules:$NODE_PATH"

    # PYTHON_SHARE
    # Python Shared Path from Homebrew I believe
    export PYTHON_SHARE='/usr/local/share/python'

    # Those NODE & Python Paths won't break anything even if you
    # don't have NODE or Python installed. Eventually you will and
    # then you don't have to update your bash_profile

  # Configurations

    # GIT_MERGE_AUTO_EDIT
    # This variable configures git to not require a message when you merge.
    export GIT_MERGE_AUTOEDIT='no'

    # Editors
    # Tells your shell that when a program requires various editors, use sublime.
    # The -w flag tells your shell to wait until sublime exits
    export VISUAL="subl -w"
    export SVN_EDITOR="subl -w"
    export GIT_EDITOR="subl -w"
    export EDITOR="subl -w"


    export PATH="/usr/local:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/local/mysql/bin:$PYTHON_SHARE:$PATH"

# Aliases
function desktop {
  cd /Users/avi/Desktop/$@
}
function code {
  cd /Users/avi/Development/code/$@
}

# The Hard Way
alias mate='subl '
alias git='hub '
alias irb='pry '

# Subversion
alias sup="svn update"
alias sst="svn status"
alias scom="svn commit"
alias sd="svn diff | mate"
alias slog="svn log | mate"
alias sex="svn export"
alias sad="svn add "
alias srm="svn remove "
alias sad="svn add "
alias sadd='svn status | grep "^\?" | awk "{print $2}" | xargs svn add' #adds all new files to svn
alias srmm='svn status | grep "\!"  | awk "{print $2;}" | xargs svn rm' #removes all missing files from svn

# Git
alias gst="git status"
alias gl="git pull"
alias gp="git push"
alias gd="git diff | mate"
alias gc="git commit -v"
alias gca="git commit -v -a"
alias gb="git branch"
alias gba="git branch -a"

# TextMate
alias et="mate . &"
alias ett="mate app config lib db public test spec vendor/plugins data features uploaders BRANCH Gemfile Rakefile &"

# Rails
alias kl_ruby="killall -9 ruby"
alias bur='bundle exec rake'

# Cucumber
alias buc='bundle exec cucumber -r features features'
alias bic='bundle exec cucumber -p wip'

# Bundler
alias bi='bundle install'
alias bb='bundle exec !!'

function bec {
  bundle exec $@
}

function ss {
  if [ -e script/rails ]; then
    script/rails server $@
  else
    script/server $@
  fi
}
function sc {
  if [ -e script/rails ]; then
    script/rails console $@
  else
    script/console $@
  fi
}
function sg {
  if [ -e script/rails ]; then
    script/rails generate $@
  else
    script/generate $@
  fi
}

# Ruby
alias sgi="sudo gem install "

# Memcached
alias kl_memcached="killall -9 memcached"

# A Better Rsynched Based SCP
alias scrp="rsync --partial --progress --rsh=ssh"

# grep for a process
function psg {
  FIRST=`echo $1 | sed -e 's/^\(.\).*/\1/'`
  REST=`echo $1 | sed -e 's/^.\(.*\)/\1/'`
  ps aux | grep "[$FIRST]$REST"
}

# disk usage human readable AND sorted by size
# usage:
# duf /*
function duf {
  du -sk "$@" | sort -nr | while read size fname; do for unit in k M G T P E Z Y; do if [ $size -lt 1024 ]; then echo -e "${size}${unit}\t${fname}"; break; fi; size=$((size/1024)); done; done
}

# extract anything
function extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)  tar xjf $1      ;;
            *.tar.gz)   tar xzf $1      ;;
            *.bz2)      bunzip2 $1      ;;
            *.rar)      rar x $1        ;;
            *.gz)       gunzip $1       ;;
            *.tar)      tar xf $1       ;;
            *.tbz2)     tar xjf $1      ;;
            *.tgz)      tar xzf $1      ;;
            *.zip)      unzip $1        ;;
            *.Z)        uncompress $1   ;;
            *)          echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# # teach shell to treat aliases like symbolic links rather than files
# function cd {
#        if [ ${#1} == 0 ]; then
#                builtin cd
#        elif [[ -d "${1}" || -L "${1}" ]]; then # regular link or directory
#                builtin cd "${1}"
#        elif [ -f "${1}" ]; then        # file: is it an alias?
#                # Redirect stderr to dev null to suppress OSA environment errors
#                exec 6>&2 # Link file descriptor 6 with stderr so we can restore stderr later
#                exec 2>/dev/null # stderr replaced by /dev/null
#                path=$(osascript << EOF
# tell application "Finder"
# set theItem to (POSIX file "${1}") as alias
# if the kind of theItem is "alias" then
# get the posix path of ((original item of theItem) as text)
# end if
# end tell
# EOF
# )
#                exec 2>&6 6>&-      # Restore stderr and close file descriptor #6.
#
#                if [ "$path" == '' ];then # probably not an alias, but regular file
#                        builtin cd "${1}"       # will trigger regular shell error about cd to regular file
#                else    # is alias, so use the returned path of the alias
#                        builtin cd "$path"
#                fi
#        else    # should never get here, but just in case.
#                builtin cd "${1}"
#        fi
#
# }

if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

# Adds autocomplete to commands
complete -o dirnames code

# Autocomplete for rake
function _rake_cache_path() {
  # If in a Rails app, put the cache in the cache dir
  # so version control ignores it
  if [ -e 'tmp/cache' ]; then
    prefix='tmp/cache/'
  fi
  echo "${prefix}.rake_t_cache"
}

function rake_cache_store() {
  rake --tasks --silent > "$(_rake_cache_path)"
}

function rake_cache_clear() {
  rm -f .rake_t_cache
  rm -f tmp/cache/.rake_t_cache
}

export COMP_WORDBREAKS=${COMP_WORDBREAKS/\:/}

function _rakecomplete() {
  # error if no Rakefile
  if [ ! -e Rakefile ]; then
    echo "missing Rakefile"
    return 1
  fi

  # build cache if missing
  if [ ! -e "$(_rake_cache_path)" ]; then
    rake_cache_store
  fi

  local tasks=`awk '{print $2}' "$(_rake_cache_path)"`
  COMPREPLY=($(compgen -W "${tasks}" -- ${COMP_WORDS[COMP_CWORD]}))
  return 0
}

complete -o default -o nospace -F _rakecomplete rake

[[ -s "/Users/avi/.rvm/scripts/rvm" ]] && source "/Users/avi/.rvm/scripts/rvm"  # This loads RVM into a shell session.
