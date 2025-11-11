function ghu
    git fetch --prune
    set current (git branch --show-current)
    echo "Deleting local branches with gone upstreams (excluding '$current')..."
    git branch -vv | awk '/: gone]/{print $1}' | grep -v "^$current\$" | tee /dev/stderr | xargs -r git branch -d
    git pull
end
