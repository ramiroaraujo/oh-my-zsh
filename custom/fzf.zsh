# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)

# fbr - checkout git branch (including remote branches), sorted by most recent commit, limit 30 last branches
fgco() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

bindkey '^e' fzf-cd-widget

lias() {
  local alias command
  alias=$(alias | fzf)
  [[ $alias =~ '^(.+)=' ]] && command=$match[1]
  print -z "$command "
}
