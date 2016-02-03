class Msmtp < Formula
  homepage "http://msmtp.sourceforge.net"
  url "https://downloads.sourceforge.net/project/msmtp/msmtp/1.6.0/msmtp-1.6.0.tar.xz"
  sha1 "39e597619f797ec3550c0146cd3d9e55e85947eb"

  bottle do
    sha1 "fbaed1978a9563b9959f1bff2d6f8c4fe891bdfc" => :yosemite
    sha1 "922ed1dfb73c3d41f1adfb92d19c283b09b65f0d" => :mavericks
    sha1 "c417014238a47adbd59eb45810f463163c1eefa2" => :mountain_lion
  end

  depends_on "pkg-config" => :build
  depends_on "openssl"

  def install
    args = %W[
      --disable-dependency-tracking
      --with-macosx-keyring
      --prefix=#{prefix}
      --with-ssl=openssl
    ]

    system "./configure", *args
    system "make", "install"
    (share/"msmtp/scripts").install "scripts/msmtpq"
  end
end
