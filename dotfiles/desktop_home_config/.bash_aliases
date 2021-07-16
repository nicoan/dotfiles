##
# Git
##
parse_git_branch() {
  gitbranch=`git branch 2> /dev/null | grep -E '^\*' | awk '{print $2}'`
  echo $gitbranch
}

git-stash-apply-name() {
  stash=`git stash list | grep -w "$1" | cut -d ':' -f1`
  git stash apply $stash
}

git-stash-pop-name() {
  stash=`git stash list | grep -w "$1" | cut -d ':' -f1`
  git stash apply $stash
}

git-rm-local-branches-not-in-remote() {
  REMOTE="${1:-origin}"
  read -p "Are you sure? This will erase ALL branches that are not present in remote ($REMOTE) (Even the ones you never pushed) " -n 1 -r
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    git branch -r | egrep -v -f /dev/fd/0  <(git branch -vv | grep origin | grep gone) | awk '{print $1}' # | xargs git branch -D
  fi
}

alias git-undo-last-commit='git reset HEAD~'
alias git-stash-name='git stash save "$1"'
alias git-clean-modified='git reset && git checkout .'
alias git-pull-submodules='git pull --recurse-submodules'

##
# Prompt
##
git_branch() {
  BRANCH=`parse_git_branch`
  [[ ! -z "$BRANCH" ]] && echo -e "──[\e[1;35m${BRANCH}\e[0;34m]" || echo ""
}

PS1="\n\[\e[0;34m\]┌─[\[\e[1;36m\u\e[1;35m\]@\[\e[1;36m\]${HOSTNAME%%.*}\[\e[0;34m\]]──[\e[1;35m\]\$\e[0;34m\]]──[\e[1;37m\w\e[0;34m]\$(git_branch)\[\e[0;34m\] \[\e[0;34m\]\n\[\e[0;34m\]└────╼ \[\e[1;35m\]» \[\e[00;00m\]"

##
# General
##
alias lg="lazygit"
alias vim="nvim"
alias vi="nvim"
alias restart_network="systemctl restart network-manager"
alias ifconfig="ip a"
alias ports_in_use='sudo lsof -i -P -n | grep LISTEN'

# Disable Bell
if [ -n "$DISPLAY" ]; then
  xset b off
fi

##
# Environment variables
export SCRIPTS_DIR=$HOME/.config/i3blocks
export THELOUNGE_HOME=$HOME/.config/thelounge
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"

