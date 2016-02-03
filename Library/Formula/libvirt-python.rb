require "formula"

class LibvirtPython < Formula
  homepage "http://www.libvirt.org"

  stable do
    url "http://libvirt.org/sources/python/libvirt-python-1.2.11.tar.gz"
    sha1 "e523be99b7ef6def64b0e7f1f715f8c67b72bbba"
  end

  head do
    url "git://libvirt.org/libvirt-python.git"
  end

  depends_on "libvirt"
  depends_on "pkg-config" => :build
  depends_on "python"

  def install
    system "python", "setup.py", "install", "--prefix=#{prefix}"
  end
end
