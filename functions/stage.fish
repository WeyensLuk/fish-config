function stage
  git ls-files --deleted --modified --other --exclude-standard | fzf -0 -m --preview 'git diff --color=always {}' | xargs -I {} -r git add "{}"
end
