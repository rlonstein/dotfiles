func dpgo() {
     export GOPATH=$HOME/datapipe/repos/go
     export PATH=$PATH:$GOPATH/bin
}

func rlgo() {
    export GOPATH=$HOME/go
    export PATH=$PATH:$GOPATH/bin
}

func _local_sshkeys(){
    keyfiles=(`find $HOME/.ssh -type f \
        -not -regex '.*\(pub\|bad\|old\|tgz\)' \
        -and -not -regex '.*\(authorized\|config\|environ\|known\).*' \
        -and -regex '.*\(id\|lonstein\).*' | sort`)

    for key in $keyfiles; do
        ssh-add $key
    done
}
