alias ls='ls --color=auto'
alias lsa='ls -A'
alias lsd='ls -d *(/)'
alias ll='ls -lAh'

if [[ "${OS}" = "Linux" ]]; then
  alias atime="stat -c '%X (%x) %n'"
  alias mtime="stat -c '%Y (%y) %n'"
  alias owner="stat -c '%U (%u) %n'"
  alias group="stat -c '%G (%g) %n'"
else
  # NetBSD stat, works for OSX and some BSDs
  alias atime="stat -f '%Sa (%a) %N'"
  alias mtime="stat -f '%Sm (%m) %N'"
  alias owner="stat -f '%Su (%u) %N'"
  alias group="stat -f '%Sg (%g) %N'"
fi

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias hexdump='od -A x -t x1z -v'

