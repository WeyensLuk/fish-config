function stage
  git ls-files --deleted --modified --other --exclude-standard | fzf -0 -m --preview 'bat --diff --paging=never --color=always {}' | xargs -I {} -r git add "{}"
end
