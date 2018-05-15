_font_install_iosevka() {
    local LATEST_IOSEVKA_VERSION=$(curl -L -s -H 'Accept: application/json' https://github.com/be5invis/iosevka/releases/latest | sed -e 's/.*"tag_name":"v\([^"]*\)".*/\1/')
    local TMPDIR=$(mktemp -d -p /tmp fonts-XXXXXXXX)
    local FONTDIR="/usr/local/share/fonts"

    local fontnames=(
        '01-iosevka'
        '02-iosevka-term'
        '03-iosevka-type'
        '04-iosevka-cc'
        '05-iosevka-slab'
        '06-iosevka-term-slab'
        '07-iosevka-type-slab'
        '08-iosevka-cc-slab'
    )

    for f in ${fontnames}; do
        fn=$(printf '%s-%s.zip' $f $LATEST_IOSEVKA_VERSION)
        echo "Downloading $fn"
        curl -# -L -o $TMPDIR/$fn https://github.com/be5invis/Iosevka/releases/download/v$LATEST_IOSEVKA_VERSION/$fn
    done

    cd $FONTDIR
    for f in $(ls $TMPDIR/0[1-8]-iosevka*.zip); do
        sudo unzip -j $f 'ttf/*.ttf'
    done

    sudo fc-cache -f -v

    rm -rf $TMPDIR
}
