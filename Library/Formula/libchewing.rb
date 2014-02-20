require 'formula'

class Libchewing < Formula
  homepage 'http://chewing.im/'
  url 'https://github.com/chewing/libchewing/releases/download/v0.3.5/libchewing-0.3.5.tar.bz2'
  sha1 '5ee3941f0f62fa14fbda53e1032970b04a7a88b7'

  head 'https://github.com/chewing/libchewing.git'

  depends_on 'cmake' => :build
  depends_on 'texinfo' => :build

  def install
    mkdir 'libchewing-build' do
      system "cmake", "..", *std_cmake_args
      system "make install"
    end
  end
end
