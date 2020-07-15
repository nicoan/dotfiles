# ###############
#   Git commands
# ###############
parse_git_branch() {
  gitbranch=`git branch 2> /dev/null | grep -E '^\*' | awk '{print $2}'`
  echo $gitbranch
}

apply_stash_name() {
  stash=`git stash list | grep -w "$1" | cut -d ':' -f1`
  git stash apply $stash
}

pop_stash_name() {
  stash=`git stash list | grep -w "$1" | cut -d ':' -f1`
  git stash apply $stash
}

alias git-undo-last-commit='git reset HEAD~'
alias git-stash-name='git stash save "$1"'
alias git-stash-apply-name=apply_stash_name
alias git-stash-pop-name=pop_stash_name
alias git-clean-modified='git reset && git checkout .'
alias git-addall-commit="git add . && git commit -m '$1'"
alias git-pull-submodules='git pull --recurse-submodules'
