#!/usr/bin/env zsh
#
# Install the various Go dev tools
#

if [ -z $GOPATH ]; then
    print -P "%B%F{red}GOPATH not set%b%f"
    exit 1
fi

tools=(
  github.com/GoASTScanner/gas
  github.com/Masterminds/glide
  github.com/alecthomas/gometalinter
  github.com/davecgh/go-spew/spew
  github.com/derekparker/delve/cmd/dlv
  github.com/golang/lint/golint
  github.com/kisielk/errcheck
  github.com/ksubedi/gomove
  github.com/mdempsky/unconvert
  github.com/motemen/gore
  github.com/mvdan/interfacer
  github.com/nsf/gocode
  github.com/opennota/check/cmd/aligncheck
  github.com/opennota/check/cmd/structcheck
  github.com/opennota/check/cmd/varcheck
  github.com/rogpeppe/godef
  github.com/smartystreets/goconvey
  github.com/sqs/goreturns
  golang.org/x/tools/cmd/godoc
  golang.org/x/tools/cmd/gorename
  honnef.co/go/tools/cmd/gosimple
  honnef.co/go/tools/cmd/megacheck
  honnef.co/go/tools/cmd/staticcheck
  honnef.co/go/tools/cmd/structlayout
  honnef.co/go/tools/cmd/structlayout-optimize
  honnef.co/go/tools/cmd/structlayout-pretty
  honnef.co/go/tools/cmd/unused
)

typeset -U tools

for pkg in ${tools}; do
    print -P -n "\e[s%F{green}Getting: ${pkg}...%f"
    go get -u ${pkg} || break
    print -P -n "\e[u%E"
done
