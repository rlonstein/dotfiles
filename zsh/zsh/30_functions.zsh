showoptions() {
    local k
    zmodload -i zsh/parameter
    for k in ${(ok)options}; do
        printf "%-20s\t%s\n" $k ${options[$k]}
    done
}
