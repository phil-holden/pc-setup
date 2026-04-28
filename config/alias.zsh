# terraform
alias tf="terraform"
alias tfi="terraform init"
alias tfv="terraform validate"
alias tfp="terraform plan"
alias tfa="terraform apply"

# git
alias g="git"
alias gc="git clone"
alias gpl="git pull"
alias gpu="git push"

# util
alias cls="clear"

# bedrock
function brs() {
    export STORAGE_ACCOUNT="$1"
    export ARM_ACCESS_KEY=`az storage account keys list -n $STORAGE_ACCOUNT | jq '.[0] | .value'`
}

copy_commit_to () {
        local target=$1
        local commit=$2

        if [[ -z $target ]]; then
                echo "1st arg 'target' is required, supply a path to the target repo to clone the commit to."
                return
        fi

    echo "1st arg passed in as: '$target'"
    local rootdir=~/git-repos # modify this to match where your repos are stored
    local basedir=$target

        if [[ ! -d "$basedir/.git" ]]; then
                echo "The path $target does not contain a '.git' dir so is not a valid repo."
        local project=$(basename $PWD)
        local basedir=$rootdir/$target/$project
        # when target is not as direct path to a git repo, we try to derive this using the following convention:
        # eg: when current path is:
        # ├── <root>
        # │&nbsp;&nbsp; ├── <x>
        # │&nbsp;&nbsp; │&nbsp;&nbsp; ├── <repo>
        # │&nbsp;&nbsp; ├── <y>
        # │&nbsp;&nbsp; │&nbsp;&nbsp; ├── <repo>
                if [[ ! -d "$basedir/.git" ]]; then
                        echo "The path $basedir does not contain a '.git' dir so is not a valid repo."
            return
        fi
        fi

        if [[ -z $commit ]]; then
                local commit=$(git rev-parse --short HEAD)
                echo "A SHA commit was not passed. Fetching the latest SHA $commit to use instead."
        else
                local revert_checkout="true"
                git checkout $commit
        fi

        local action=""
        # for i in $(git show --pretty="" --name-only $commit | sort -u );do
        for i in $(git log -m -1 --name-only --pretty="format:" $commit | sort -u );do
                scr_dir=./$i
                dst_dir=$basedir/$i

                dirname=$(dirname $i)
                mkdir -p $basedir/$dirname

                # Command: "git log" will show all files which have been modified for a given commit.
                # It can not distinguish between files being added, removed or modified, so we
                # will attempt to check this on the file system and take the appropriate action.
                if [[ -f $scr_dir ]]; then
                        [[ -f $dst_dir ]] && action="updated" || action="added"
                        cp $scr_dir $dst_dir
                else
                        action="removed"
                        [[ -f $dst_dir ]] && rm -f $dst_dir
                fi

                echo "* $action file: $dst_dir"
        done

        [[ -n $revert_checkout ]] && git checkout -
        [[ -n $action ]] && echo "Done. cloned commit $commit to repo at: $basedir"
}
alias cc="copy_commit_to"
