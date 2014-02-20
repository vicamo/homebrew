require 'formula'

class Dosfstools < Formula
  homepage 'http://daniel-baumann.ch/software/dosfstools/'
  url 'http://daniel-baumann.ch/files/software/dosfstools/dosfstools-3.0.26.tar.gz'
  sha1 '18a94a229867d9cb25d6c47c5c45563caa073cf0'

  head 'https://daniel-baumann.ch/git/software/dosfstools.git'

  def install
    system "make"
    system "make", "DESTDIR=#{prefix}", "install"
  end
end
