require "formula"

class Urlgrabber < Formula
  homepage "http://urlgrabber.baseurl.org/"

  stable do
    url "git://yum.baseurl.org/urlgrabber.git", :tag => "urlgrabber-3-10-1"
  end

  head do
    url "git://yum.baseurl.org/urlgrabber.git"
  end

  depends_on "pycurl"
  depends_on "python"

  def install
    system "python", "setup.py", "install", "--prefix=#{prefix}"
  end
end
