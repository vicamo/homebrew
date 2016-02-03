require "formula"

class Pycurl < Formula
  homepage "http://pycurl.sourceforge.net/"

  stable do
    url "http://pycurl.sourceforge.net/download/pycurl-7.19.5.tar.gz"
    sha1 "ec36d55a99db9a49fede3bfa27ee16a4f5dc7bef"
  end

  head do
    url "https://github.com/pycurl/pycurl.git"
  end

  depends_on "python"

  def install
    system "python", "setup.py", "install", "--prefix=#{prefix}"
  end
end
