require "formula"

class IpaddrPy < Formula
  homepage "https://code.google.com/p/ipaddr-py/"

  stable do
    url "https://ipaddr-py.googlecode.com/files/ipaddr-2.1.10.tar.gz"
    sha1 "c608450b077b19773d4f1b5f1ef88b26f6650ce0"
  end

  depends_on "python"

  def install
    system "python", "setup.py", "install", "--prefix=#{prefix}"
  end
end
