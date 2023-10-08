# .profile
export PATH="$PATH:/usr/local/bin/"
export PATH="$PATH:$HOME/.composer/vendor/bin"
export EDITOR='subl -w'

alias desktop="cd ~/Desktop"
alias downloads="cd ~/Downloads"
alias documents="cd ~/Documents"
alias dotfiles="subl ~/Library/Mobile\ Documents/com~apple~CloudDocs/dotfiles"
alias trak="cd ~/Developer/trak/sponsorship"

alias art="php artisan"
alias docs="php artisan l5-swagger:generate"

alias yw="yarn install && yarn watch"
alias yp="yarn install && yarn prod"
alias yr="rm -rf node_modules && yarn install && yarn prod"


alias profile="source ~/.profile"
alias bashconfig="subl ~/.profile"
alias awsconfig="subl ~/.aws"
alias gitconfig="subl ~/.gitconfig"

alias sublimeconfig="subl ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User"
alias snippets="subl ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/snippets"


fullscreen() {
    /usr/bin/osascript -e "tell application $1" -e "activate"-e "tell application \"System Events\""-e "keystroke \"f\" using {control down, command down}"-e "end tell"-e "end tell"
}
start() {
    sponsorship

    open "/Applications/Slack.app"
    open "/Applications/Spark.app"
}
sponsorship() {
    cd ~/Developer/trak/sponsorship
    subl .
    github .

    url="https://sponsorship.trak.test"
    open -na "Google Chrome" --args ${url}
}
manage() {
    cd ~/Developer/trak/management
    subl .
    github .

    url="https://manage.trak.test"
    open -na "Google Chrome" --args ${url}
}
alias management="manage"

sshtrak() {
    ip=$(ping -c 1 www.google.com | gawk -F'[()]' '/PING/{print $2}')

    echo ip
}

sshkey() {
    cat ~/.ssh/id_rsa.pub
}
bcrypt() {
    htpasswd -bnBC 12 "" $1 | tr -d ':\n'
}


jsonattribute() {
    python -c "import sys,json; obj=json.loads('$1'); sys.stdout.write(json.dumps(obj['$2']))"
}
awskey() {
    json=$(terraform output -json access_keys | python -c "import sys,json; obj=json.load(sys.stdin); sys.stdout.write(json.dumps(obj['$1']))")

    id=$(jsonattribute $json 'id');
    secret=$(jsonattribute $json 'secret');
    bucket=$(jsonattribute $json 'user');

    echo "AWS_KEY=${id}"
    echo "AWS_SECRET=${secret}"
    echo "AWS_REGION=us-west-2"
    echo "AWS_BUCKET=${bucket}"
}

pr() {
    repo=$(basename -s .git `git config --get remote.origin.url`)
    branch=$(git branch --show-current)
    url="https://github.com/traksoftware/${repo}/compare/development...${branch}"

    echo "Repository: traksoftware/${repo}"
    echo "Branch: ${branch}"
    echo "Opening PR: ${url}"

    open -na "Google Chrome" --args --new-window ${url}
}

snippet() {
    filename="trak-${1}.sublime-snippet"

    cd ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/snippets

    echo "Creating: ${filename}"
    cp trak-template.sublime-snippet ${filename}
    sed -i '' "s/TEMPLATE/$1/" "${filename}"
    snippets
    subl ${filename}

    cd -
}

source /usr/local/opt/nvm/nvm.sh
