require "formula"

class VirtViewer < Formula
  homepage "http://virt-manager.org/"
  url "http://virt-manager.org/download/sources/virt-viewer/virt-viewer-1.0.tar.gz"
  sha1 "9b3463ef8cf21d648dcc4fb012d093ba3f2c537b"

  depends_on "gettext" => :build
  depends_on "glib"
  depends_on "gtk-vnc"
  depends_on "intltool" => :build
  depends_on "libvirt"
  depends_on "pkg-config" => :build
  depends_on "shared-mime-info" => :build

  def install
    args = ["--prefix=#{prefix}",
            "--mandir=#{man}",
            "--with-gtk=3.0"]

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
