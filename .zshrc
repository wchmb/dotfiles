# Make these arrays Unique: remove dups automatically
typeset -U path cdpath fpath manpath

path=(
  $HOME/.emacs.d/bin
  $HOME/.docker/bin
  $HOME/.local/bin
  /Library/Developer/CommandLineTools/usr/bin
  $HOME/Library/Python/3.9/bin
  ${path[@]}
)
export PATH

fpath=(
  $HOME/.docker/completions
  ${fpath[@]}
)

export HISTTIMEFORMAT="%F %T "
export HOMEBREW_NO_ENV_HINTS=1

# Activate TAB completion
autoload -Uz compinit
compinit

alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
compdef dot=git # Enable git completions for dot

# History {{{
setopt append_history    # Append history
setopt extended_history  # Save timestamp and the duration
setopt histignorealldups # Remove dups
# }}}

# Dirstack {{{
setopt auto_pushd        # Make cd push the old directory onto the directory stack.
setopt pushd_silent      # Push silently
setopt pushd_to_home     # Push with no arguments act like pushd $HOME
setopt pushd_ignore_dups # Don't push the same dir twice
# }}}

# Other stuff {{{
setopt correctall          # Spelling correction for commands and  arguments
setopt extendedglob        # Treat the ‘#’, ‘~’ and ‘^’ as patterns for filename generation, etc
setopt nomatch             # Error if a filename generation pattern has no matches
setopt interactivecomments # Comments beginis with a #
setopt longlistjobs        # Display PID when suspending processes as well
setopt notify              # Report the status of backgrounds jobs immediately
setopt hash_list_all       # Hash the entire command path on command comletion
setopt completeinword      # Not just at the end
setopt nohup               # Don't SIGHUP to bg processes when exiting the shell
setopt nobeep              # Don't beep
# }}}
