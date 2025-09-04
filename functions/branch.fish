function branch
    set -l formatted_text (string replace -a ' ' '-' -- $argv[2..-1])
    set formatted_text (string replace -a \' '' -- $formatted_text)
    set -l branch_name "TSB-$argv[1]_$formatted_text"
    git checkout -B $branch_name;
end