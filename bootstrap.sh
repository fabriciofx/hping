#!/bin/bash
set -e

clean() {
    echo -n "Cleaning created files... "
    rm -rf autom4te.cache aclocal.m4 Makefile.in src/Makefile.in m4/* \
        src/.deps src/.libs configure config.status compile config.guess \
        config.sub depcomp install-sh ltmain.sh missing src/byteorder.h \
        config.log libtool Makefile src/Makefile src/*.o src/.depend \
        byteorder
    echo "done."
}

byteorder() {
    echo -n "Creating src/byteorder.h file... "
    make byteorder > /dev/null
    BYTEORDER=$(./byteorder m)
    cat > src/byteorder.h <<EOF
#ifndef __BYTEORDER_H
#define __BYTEORDER_H
EOF
    echo "#ifndef $BYTEORDER" >> src/byteorder.h
    echo "#define $BYTEORDER" >> src/byteorder.h
    echo "#endif /* $BYTEORDER */" >> src/byteorder.h
cat >> src/byteorder.h <<EOF
#endif /* __BYTEORDER_H */
EOF
    echo "done."
}

build() {
    byteorder
    echo "Creating configure and support files... "
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
    *)
        clean
        build
        ;;
esac
