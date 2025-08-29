#!/bin/bash
set -e

clean() {
    echo -n "Cleaning created files... "
    rm -rf autom4te.cache aclocal.m4 Makefile.in src/Makefile.in m4/* \
        src/.deps src/.libs configure config.status compile config.guess \
        config.sub depcomp install-sh ltmain.sh missing config.log libtool \
        Makefile src/Makefile src/*.o src/.depend .depend config.h.in* \
        config.h stamp-h1 src/hping3
    echo "done."
}

dist() {
    echo -n "Cleaning temporary files... "
    rm -rf autom4te.cache aclocal.m4 Makefile.in src/Makefile.in m4/* \
        src/.deps src/.libs config.status compile config.guess \
        config.sub depcomp install-sh ltmain.sh missing \
        config.log libtool Makefile src/Makefile src/*.o src/.depend \
        .depend config.h.in* config.h stamp-h1 src/hping3
    echo "done."
}

build() {
    echo "Creating configure and support files... "
    # Create config.h.in
    autoheader
    # Create libtool files
    glibtoolize --force
    # Create aclocal macros
    aclocal
    # Create configure
    autoconf
    # Create Makefile.in
    automake --add-missing
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
