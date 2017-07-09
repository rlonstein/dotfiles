# Misc docker-related shortcuts

function dm-env() {
  eval "$(docker-machine env "${1:-default}")"
}

function docker-clean() {
  docker rmi -f $(docker images -q -a -f dangling=true)
}

function aws-ecr-creds() {
  eval "$(aws ecr get-login)"
}

alias de="env | grep DOCKER_"
alias dm-list="docker-machine ls"
alias dps="docker ps -a"
alias di="docker images"
alias drm='docker ps -a | awk '"'"'/^[0-9a-z][0-9a-z]/{print $1}'"'"' | xargs -n1 docker rm'
