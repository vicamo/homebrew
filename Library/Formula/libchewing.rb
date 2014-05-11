require 'formula'

class Libchewing < Formula
  homepage 'http://chewing.im/'
  head 'https://github.com/vicamo/libchewing.git'

  depends_on 'cmake' => :build
  depends_on 'texinfo' => :build

  def install
    mkdir 'libchewing-build' do
      system "cmake", "..", *std_cmake_args
      system "make install"
    end
  end
end
