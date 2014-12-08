class VirtManager < Formula
  desc "Desktop tool for managing virtual machines via libvirt"
  homepage "http://virt-manager.org/"
  url "http://virt-manager.org/download/sources/virt-manager/virt-manager-1.3.2.tar.gz"
  sha256 "270c1f631fd029fee5291e83f50d69e261db666aa952c184643bc6cece77fdb3"
  head "https://github.com/virt-manager/virt-manager.git"

  depends_on "intltool" => :build

  depends_on "glib"
  depends_on "gtk+3"
  depends_on "libvirt-python"
  depends_on :python if MacOS.version <= :snow_leopard

  resource "pip" do
    url "https://pypi.python.org/packages/source/p/pip/pip-7.1.2.tar.gz"
    sha256 "ca047986f0528cfa975a14fb9f7f106271d4e0c3fe1ddced6c1db2e7ae57a477"
  end

  resource "ipaddr" do
    url "https://pypi.python.org/packages/source/i/ipaddr/ipaddr-2.1.11.tar.gz"
    sha256 "1b555b8a8800134fdafe32b7d0cb52f5bdbfdd093707c3dd484c5ea59f1d98b7"
  end

  resource "setuptools" do
    url "https://pypi.python.org/packages/source/s/setuptools/setuptools-19.4.tar.gz"
    sha256 "214bf29933f47cf25e6faa569f710731728a07a19cae91ea64f826051f68a8cf"
  end

  def install
    ENV.prepend_create_path "PYTHONPATH", libexec/"vendor/lib/python2.7/site-packages"
    %w[setuptools pip ipaddr].each do |r|
      resource(r).stage do
        system "python", *Language::Python.setup_install_args(libexec/"vendor")
      end
    end

    system "python", "setup.py", "--no-user-cfg", "configure", "--prefix=#{prefix}"
    system "python", "setup.py", "--no-update-icon-cache", "--no-compile-schemas", "install", "--prefix=#{prefix}"

    inreplace Dir["#{share}/virt-manager/*"], "#!/usr/bin/python2", "#!/usr/bin/env python"
  end

  test do
    system "ls"
  end
end
