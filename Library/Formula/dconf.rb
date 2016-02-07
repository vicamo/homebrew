class Dconf < Formula
  desc "Simple key-based configuration system"
  homepage "https://wiki.gnome.org/Projects/dconf"
  url "https://download.gnome.org/sources/dconf/0.25/dconf-0.25.1.tar.xz"
  sha256 "5011982b2b81c531f557d2abed215bb78223b6e75f0c92aaf6b73d3c8aa711d1"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "glib"
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  # upstream bug: https://bugzilla.gnome.org/show_bug.cgi?id=720403
  patch :DATA

  def install
    system "glibtoolize", "--copy", "--force"
    system "aclocal"
    system "autoheader"
    system "automake", "--add-missing"
    system "autoconf"

    args = %W[
      --prefix=#{prefix}
      --disable-silent-rules
      --disable-dependency-tracking
      --disable-schemas-compile
    ]

    system "./configure", *args
    system "make", "install"
  end

  def post_install
    system "#{Formula["glib"].opt_bin}/glib-compile-schemas", "#{HOMEBREW_PREFIX}/share/glib-2.0/schemas"
  end

  test do
    system "false"
  end
end

__END__
diff -Nur dconf-0.25.1/client/Makefile.am b/client/Makefile.am
--- dconf-0.25.1/client/Makefile.am	2013-11-25 11:26:09.000000000 +0800
+++ b/client/Makefile.am	2016-02-07 11:49:52.000000000 +0800
@@ -1,39 +1,26 @@
 include $(top_srcdir)/Makefile.gtester
 
-shlibdir=$(libdir)
-shlib_PROGRAMS = libdconf.so.1.0.0
-nodist_noinst_DATA = libdconf.so.1 libdconf.so
-noinst_LIBRARIES = libdconf-client.a
-
-libdconf.so.1 libdconf.so: libdconf.so.1.0.0
-	$(AM_V_GEN) ln -fs libdconf.so.1.0.0 $@
-
-install-data-hook:
-	ln -fs libdconf.so.1.0.0 $(DESTDIR)$(shlibdir)/libdconf.so.1
-	ln -fs libdconf.so.1.0.0 $(DESTDIR)$(shlibdir)/libdconf.so
-
-uninstall-hook:
-	rm -f $(DESTDIR)$(shlibdir)/libdconf.so.1
-	rm -f $(DESTDIR)$(shlibdir)/libdconf.so
+lib_LTLIBRARIES = libdconf.la
+noinst_LTLIBRARIES = libdconf-client.la
 
 dconfinclude_HEADERS = dconf.h
 dconfclientinclude_HEADERS = dconf-client.h
 dconfclientincludedir = $(dconfincludedir)/client
 
-libdconf_client_a_CFLAGS = $(gio_CFLAGS) -DG_LOG_DOMAIN=\"dconf\"
-libdconf_client_a_SOURCES = \
+libdconf_client_la_CFLAGS = $(gio_CFLAGS) -DG_LOG_DOMAIN=\"dconf\"
+libdconf_client_la_SOURCES = \
 	dconf-client.c
 
-libdconf_so_1_0_0_CFLAGS = $(libdconf_client_a_CFLAGS) -fPIC -DPIC
-libdconf_so_1_0_0_LDADD = \
+libdconf_la_CFLAGS = $(libdconf_client_la_CFLAGS) -fPIC -DPIC
+libdconf_la_LIBADD = \
 	../engine/libdconf-engine-shared.a		\
 	../common/libdconf-common-shared.a		\
 	../gdbus/libdconf-gdbus-thread-shared.a		\
 	../gvdb/libgvdb-shared.a			\
 	../shm/libdconf-shm-shared.a			\
 	$(gio_LIBS)
-libdconf_so_1_0_0_LDFLAGS = -shared -Wl,-soname=libdconf.so.1
-libdconf_so_1_0_0_SOURCES = $(libdconf_client_a_SOURCES)
+libdconf_la_LDFLAGS = -version-info $(LT_CURRENT):$(LT_REVISION):$(LT_AGE)
+libdconf_la_SOURCES = $(libdconf_client_la_SOURCES)
 
 EXTRA_DIST = dconf.vapi dconf.deps
 
@@ -42,5 +29,3 @@
 
 pkgconfigdir = $(libdir)/pkgconfig
 pkgconfig_DATA = dconf.pc
-
-CLEANFILES = libdconf.so.1 libdconf.so
diff -Nur dconf-0.25.1/configure.ac b/configure.ac
--- dconf-0.25.1/configure.ac	2015-12-17 00:31:10.000000000 +0800
+++ b/configure.ac	2016-02-07 11:47:30.000000000 +0800
@@ -11,6 +11,27 @@
 AM_INIT_AUTOMAKE([1.11.2 foreign -Wno-portability no-dist-gzip dist-xz])
 AM_SILENT_RULES([yes])
 
+dnl ################################################################
+dnl # libtool versioning
+dnl ################################################################
+dnl #
+dnl # +1 :  0 : +1   == new interface that does not break old one.
+dnl # +1 :  0 :  ?   == removed an interface. Breaks old apps.
+dnl #  ? : +1 :  ?   == internal changes that doesn't break anything.
+dnl #
+dnl # CURRENT : REVISION : AGE
+dnl #
+LT_INIT([win32-dll disable-static])
+
+LT_CURRENT=1
+LT_REVISION=0
+LT_AGE=1
+
+AC_SUBST(LT_RELEASE)
+AC_SUBST(LT_CURRENT)
+AC_SUBST(LT_REVISION)
+AC_SUBST(LT_AGE)
+
 # Set default CFLAGS before AC_PROG_CC does
 if test "${CFLAGS+yes}" != "yes"; then
   CFLAGS='-O2 -g -Wall -Wwrite-strings -Wmissing-prototypes -fno-common'
