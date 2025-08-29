#!/bin/bash
set -e

OS=$(uname | tr '[:upper:]' '[:lower:]')

# macOS uses glibtoolize
if [ "$OS" = "darwin" ]; then
    LIBTOOLIZE=glibtoolize
else
    LIBTOOLIZE=libtoolize
fi

clean() {
    echo -n "Cleaning created files... "
    rm -rf autom4te.cache aclocal.m4 Makefile.in src/Makefile.in m4/* \
        src/.deps src/.libs configure configure~ config.status compile \
        config.guess config.sub depcomp install-sh ltmain.sh missing \
        config.log libtool Makefile src/Makefile src/*.o src/.depend .depend \
        config.h.in* config.h stamp-h1 src/hping3 src/libars.a ar-lib
    echo "done."
}

dist() {
    echo -n "Cleaning temporary files... "
    rm -rf autom4te.cache aclocal.m4 m4/* src/.deps src/.libs config.status \
        config.log libtool Makefile src/Makefile src/*.o src/.depend .depend \
        config.h.in~ configure~ config.h stamp-h1 src/hping3 src/libars.a
    echo "done."
}

build() {
    echo "Creating configure and support files... "
    # Create config.h.in
    autoheader
    # Create libtool files
    $LIBTOOLIZE --force --copy
    # Create aclocal macros
    aclocal
    # Create configure
    autoconf
    # Create Makefile.in
    automake --add-missing --copy
    echo "done."
}

case "$1" in
    clean)
        clean
        ;;
    build)
        build
        ;;
    dist)
        dist
        ;;
    *)
        clean
        build
        ;;
esac
