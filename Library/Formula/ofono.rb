require 'formula'

class Ofono < Formula
  homepage 'http://ofono.org/'
  head 'https://github.com/vicamo/ofono.git', :branch => 'homebrew'

  depends_on 'libtool' => :build
  depends_on 'automake' => :build
  depends_on 'autoconf' => :build
  depends_on 'pkg-config' => :build
  depends_on 'd-bus'
  depends_on 'glib'
  depends_on 'mobile-broadband-provider-info'

  def install
    ENV["LIBTOOLIZE"] = "glibtoolize"
    system "./bootstrap-configure", "--prefix=#{prefix}", "--disable-udev"
    system "make", "install"
  end
end
