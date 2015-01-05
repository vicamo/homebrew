require "formula"

class LibvirtGlib < Formula
  homepage "http://www.libvirt.org"
  url "http://libvirt.org/sources/glib/libvirt-glib-0.1.9.tar.gz"
  sha1 "ad54f51bf2afd5c7a23b7ee81a43dc7e61eadce2"

  depends_on "gettext" => :build
  depends_on "gobject-introspection"
  depends_on "intltool"
  depends_on "libvirt"
  depends_on "pkg-config" => :build
  depends_on "vala" => :optional

  # work around ld not understanding --version-script argument
  patch :DATA

  def install
    args = ["--prefix=#{prefix}",
            "--localstatedir=#{var}",
            "--mandir=#{man}",
            "--sysconfdir=#{etc}"]

    args << "--enable-vala" if build.with? "vala"

    system "./configure", *args

    # Compilation of docs doesn"t get done if we jump straight to "make install"
    system "make"
    system "make", "install"
  end
end

__END__
diff --git a/libvirt-gconfig/Makefile.in b/libvirt-gconfig/Makefile.in
index 42e4352..d851d96 100644
--- a/libvirt-gconfig/Makefile.in
+++ b/libvirt-gconfig/Makefile.in
@@ -747,7 +747,6 @@ libvirt_gconfig_1_0_la_DEPENDENCIES = \
 libvirt_gconfig_1_0_la_LDFLAGS = \
 			$(COVERAGE_CFLAGS:-f%=-Wc,f%) \
 			$(CYGWIN_EXTRA_LDFLAGS) $(MINGW_EXTRA_LDFLAGS) \
-			-Wl,--version-script=$(srcdir)/libvirt-gconfig.sym \
 			-version-info $(LIBVIRT_GLIB_VERSION_INFO)
 
 BUILT_SOURCES = $(GCONFIG_GENERATED_FILES)
diff --git a/libvirt-glib/Makefile.in b/libvirt-glib/Makefile.in
index 3523684..a370ae8 100644
--- a/libvirt-glib/Makefile.in
+++ b/libvirt-glib/Makefile.in
@@ -436,7 +436,6 @@ libvirt_glib_1_0_la_DEPENDENCIES = \
 libvirt_glib_1_0_la_LDFLAGS = \
 			$(COVERAGE_CFLAGS:-f%=-Wc,f%) \
 			$(CYGWIN_EXTRA_LDFLAGS) $(MINGW_EXTRA_LDFLAGS) \
-			-Wl,--version-script=$(srcdir)/libvirt-glib.sym \
 			-version-info $(LIBVIRT_GLIB_VERSION_INFO)
 
 INTROSPECTION_GIRS = $(am__append_1)
diff --git a/libvirt-gobject/Makefile.in b/libvirt-gobject/Makefile.in
index 26e0df6..fb02f78 100644
--- a/libvirt-gobject/Makefile.in
+++ b/libvirt-gobject/Makefile.in
@@ -520,7 +520,6 @@ libvirt_gobject_1_0_la_DEPENDENCIES = \
 libvirt_gobject_1_0_la_LDFLAGS = \
 			$(COVERAGE_CFLAGS:-f%=-Wc,f%) \
 			$(CYGWIN_EXTRA_LDFLAGS) $(MINGW_EXTRA_LDFLAGS) \
-			-Wl,--version-script=$(srcdir)/libvirt-gobject.sym \
 			-version-info $(LIBVIRT_GLIB_VERSION_INFO)
 
 BUILT_SOURCES = $(GOBJECT_GENERATED_FILES)
