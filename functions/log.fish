function log --description "Interactive git log for current branch"
    set -l _fmt "%h %C(bold blue)%h%C(reset) %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)"

    set -l grep_args
    if test (count $argv) -gt 0
        set grep_args --grep="$argv[1]" -i
    end

    set -l commits (git log --color=always --format="tformat:$_fmt" $grep_args)

    if test (count $commits) -eq 0
        echo "No commits found"
        return
    end

    printf '%s\n' $commits | \
    fzf --ansi \
        --no-sort \
        --with-nth=2.. \
        --preview 'git show --stat --color=always {1}' \
        --preview-window 'right:60%' \
        --bind 'ctrl-d:change-preview(git show --color=always {1})' \
        --bind 'ctrl-f:change-preview(git diff-tree --no-commit-id -r --name-only {1})' \
        --bind 'ctrl-s:change-preview(git show --stat --color=always {1})' \
        --bind 'enter:become(git show --color=always {1} | less -R)' \
        --header 'ctrl-s: stat+diff  │  ctrl-d: full diff  │  ctrl-f: files only  │  enter: open in pager'
end
