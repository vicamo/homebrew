class Usbip < Formula
  desc "USB device sharing system over IP network"
  homepage "http://usbip.sourceforge.net/"
  url "http://httpredir.debian.org/debian/pool/main/l/linux-tools/linux-tools_4.4.orig.tar.xz"
  sha256 "1404533a2c9986ebbb27851f22c8841352ce7f66a237edfef1e71f0879f5c288"

  depends_on "automake" => :build
  depends_on "autoconf" => :build
  depends_on "libtool" => :build

  def install
    Dir.chdir "tools/usb/usbip"

    system "./autogen.sh"
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "false"
  end
end
