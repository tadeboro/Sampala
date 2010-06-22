test -n "$srcdir" || srcdir=$(dirname "$0")
test -n "$srcdir" || srcdit=.
(
  cd "$srcdir" &&
  AUTOPOINT='intltoolize --automake --copy' autoreconf -fiv
) || exit
test -n "$NOCONFIGURE" || "$srcdir/configure" --enable-maintainer-mode "$@"
