class VirtManager < Formula
  desc "Desktop tool for managing virtual machines via libvirt"
  homepage "http://virt-manager.org/"
  url "http://virt-manager.org/download/sources/virt-manager/virt-manager-1.3.2.tar.gz"
  sha256 "270c1f631fd029fee5291e83f50d69e261db666aa952c184643bc6cece77fdb3"
  head "https://github.com/virt-manager/virt-manager.git"

  depends_on "dbus"
  depends_on "glib"
  depends_on "gnome-icon-theme"
  depends_on "gtk+3"
  depends_on "intltool" => :build
  depends_on "libvirt"
  depends_on "vte3"

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

  resource "libvirt-python" do
    url "https://pypi.python.org/packages/source/l/libvirt-python/libvirt-python-1.3.1.tar.gz"
    sha256 "7143b922a9bd66a5e199b13316fa4266cbffc23db01c99bce37216a1eb9118f7"
  end

  def install
    vendor_site_packages = libexec/"vendor/lib/python2.7/site-packages"
    ENV.prepend_create_path "PYTHONPATH", vendor_site_packages

    resources.each do |r|
      r.stage do
        system "python", *Language::Python.setup_install_args(libexec/"vendor")
      end
    end

    # OS X does not provide a `python2` executable
    inreplace %w[virt-clone virt-convert virt-install virt-manager virt-xml],
      "#!/usr/bin/python2", "#!/usr/bin/env python"

    ENV.prepend_create_path "PYTHONPATH", libexec/"lib/python2.7/site-packages"
    # --single-version-externally-managed is not recognized by setup.py, so
    # Language::Python.setup_install_args(libexec) cannot be used here.
    system "python", "setup.py", "--no-user-cfg", "configure", "--prefix=#{libexec}"
    system "python", "setup.py", "--no-update-icon-cache", "--no-compile-schemas", "install", "--prefix=#{libexec}"

    man1.install Dir["#{libexec}/share/man/man1/*.1"]
    bin.install Dir["#{libexec}/bin/*"]
    bin.env_script_all_files(libexec/"bin", :PYTHONPATH => ENV["PYTHONPATH"])
  end

  def post_install
    system "#{Formula["glib"].opt_bin}/glib-compile-schemas", "#{HOMEBREW_PREFIX}/share/glib-2.0/schemas"
    system "#{Formula["gtk+3"].opt_bin}/gtk3-update-icon-cache", "-f", "-t", "#{HOMEBREW_PREFIX}/share/icons/hicolor"
  end

  test do
    system "ls"
  end
end
