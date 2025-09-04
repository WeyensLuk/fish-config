function revert
  git ls-files --deleted --modified --other --exclude-standard | fzf -0 -m --preview 'git diff --color=always {-1}' | xargs -r git checkout --
end