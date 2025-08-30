AC_PREREQ([2.69])
AC_INIT([hping3], [3.0.0-alpha-1], [antirez@invece.org])
AC_CONFIG_AUX_DIR([build])
AC_CONFIG_MACRO_DIRS([m4])
AM_INIT_AUTOMAKE([-Wall -Werror foreign subdir-objects])

AC_PROG_CC
AM_PROG_AR
LT_INIT

# Export this info to Makefile
AC_SUBST([PACKAGE_NAME])
AC_SUBST([PACKAGE_VERSION])

# To detect endianess
AC_C_BIGENDIAN([WORDS_BIGENDIAN])

# Create config.h
AC_CONFIG_HEADERS([config.h])

AC_CANONICAL_HOST

case "$host_os" in
  linux*)
    AC_DEFINE([OSTYPE_LINUX], [], [Define Linux as the target OS type])
    ;;
  darwin*)
    AC_DEFINE([OSTYPE_DARWIN], [], [Define Darwin as the target OS type])
    ;;
  freebsd*)
    AC_DEFINE([OSTYPE_FREEBSD], [], [Define FreeBSD as the target OS type])
    ;;
  netbsd*)
    AC_DEFINE([OSTYPE_NETBSD], [], [Define NetBSD as the target OS type])
    ;;
  openbsd*)
    AC_DEFINE([OSTYPE_OPENBSD], [], [Define OpenBSD as the target OS type])
    ;;
  bsdi*)
    AC_DEFINE([OSTYPE_BSDI], [], [Define BSDI as the target OS type])
    ;;
  *)
    os_type=UNKNOWN
    ;;
esac

AC_MSG_NOTICE([Detecting Homebrew pkg-config paths...])
case "`uname -m`" in
  x86_64)
    BREW_PKGCONFIG="/usr/local/lib/pkgconfig"
    ;;
  arm64)
    BREW_PKGCONFIG="/opt/homebrew/opt/libpcap/lib/pkgconfig"
    ;;
  *)
    BREW_PKGCONFIG=""
    ;;
esac

if test -d "$BREW_PKGCONFIG"; then
  PKG_CONFIG_PATH="$BREW_PKGCONFIG${PKG_CONFIG_PATH+:$PKG_CONFIG_PATH}"
  export PKG_CONFIG_PATH
  AC_MSG_NOTICE([PKG_CONFIG_PATH set to $PKG_CONFIG_PATH])
fi

PKG_CHECK_MODULES([PCAP], [libpcap >= 1.0],
  [AC_MSG_NOTICE([Found libpcap: $PCAP_CFLAGS $PCAP_LIBS])],
  [AC_MSG_ERROR([libpcap >= 1.0 not found. Install it via Homebrew.])])

PKG_CHECK_MODULES([TCL], [tcl >= 8.6],
  [AC_MSG_NOTICE([Found Tcl: $TCL_CFLAGS $TCL_LIBS])],
  [AC_MSG_ERROR([Tcl >= 8.6 not found. Install it via Homebrew.])])

AC_SUBST([PCAP_CFLAGS])
AC_SUBST([PCAP_LIBS])
AC_SUBST([TCL_CFLAGS])
AC_SUBST([TCL_LIBS])

AC_CONFIG_FILES([Makefile src/Makefile])
AC_OUTPUT
