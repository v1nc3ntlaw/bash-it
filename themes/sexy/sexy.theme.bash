# Sexy Bash Prompt, inspired by "Extravagant Zsh Prompt"
# Screenshot: http://cloud.gf3.ca/M5rG
# A big thanks to \amethyst on Freenode

if [[ $OSTYPE != darwin* ]]; then ]
  if [[ $COLORTERM = gnome-* && $TERM = xterm ]]  && infocmp gnome-256color >/dev/null 2>&1; then export TERM=gnome-256color
  elif [[ $TERM != dumb ]] && infocmp xterm-256color >/dev/null 2>&1; then export TERM=xterm-256color
  fi
fi

if tput setaf 1 &> /dev/null; then
    if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
      MAGENTA=$(tput setaf 9)
      ORANGE=$(tput setaf 172)
      GREEN=$(tput setaf 190)
      PURPLE=$(tput setaf 141)
      WHITE=$(tput setaf 0)
    else
      MAGENTA=$(tput setaf 5)
      ORANGE=$(tput setaf 4)
      GREEN=$(tput setaf 2)
      PURPLE=$(tput setaf 1)
      WHITE=$(tput setaf 7)
      CYAN=$(tput setaf 6)
    fi
    BOLD=$(tput bold)
    RESET=$(tput sgr0)
else
    MAGENTA="\033[1;31m"
    ORANGE="\033[1;33m"
    GREEN="\033[1;32m"
    PURPLE="\033[1;35m"
    WHITE="\033[1;37m"
    CYAN="\033[1;36m"
    BOLD=""
    RESET="\033[m"
fi

parse_git_dirty () {
  if [[ $(git status 2> /dev/null | tail -n1 | cut -c 1-17) != "nothing to commit" ]];then
    echo "✗"
  else
    echo "✓"
  fi
}
parse_git_branch () {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/$SCM_GIT_CHAR \1 $(parse_git_dirty)/"
}

function prompt_command() {
  PS1="\[${BOLD}${MAGENTA}\]\u \[$RESET\]at \[${BOLD}$ORANGE\]\h \[$RESET\]in \[${BOLD}$GREEN\]\w \[$RESET\]\nwith \[${BOLD}$PURPLE\]\$(ruby_version_prompt)\[$RESET\]\$([[ -n \$(git branch 2> /dev/null) ]] && echo \" on \")\[${BOLD}$CYAN\]\$(parse_git_branch) \[$RESET\]\$ "
}

safe_append_prompt_command prompt_command
