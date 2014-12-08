require "formula"

class VirtManager < Formula
  homepage "http://virt-manager.org/"

  stable do
    url "http://virt-manager.org/download/sources/virt-manager/virt-manager-1.1.0.tar.gz"
    sha1 "01b80584dad46fc79e57ecc3af4096332ab83fce"
  end

  head do
    url "https://git.fedorahosted.org/git/virt-manager.git"
  end

  depends_on "gettext" => :build
  depends_on "glib" => :build
  depends_on "intltool" => :build
  depends_on "ipaddr-py"
  depends_on "libvirt-python"
  depends_on "libxml2"
  depends_on "python"
  depends_on "urlgrabber"

  patch :DATA

  def install
    system "python", "setup.py", "configure", "--prefix=#{prefix}"
    system "python", "setup.py", "install", "--prefix=#{prefix}"
  end
end

__END__
diff --git a/virt-clone b/virt-clone
index 4bd5ca3..6b4b9e5 100755
--- a/virt-clone
+++ b/virt-clone
@@ -1,9 +1,9 @@
-#!/usr/bin/python2 -tt
+#!/usr/bin/env python2 -tt
 #
 # Copyright(c) FUJITSU Limited 2007.
 #
 # Script to set up an cloning guest configuration and kick off an cloning
 #
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
 # the Free  Software Foundation; either version 2 of the License, or
diff --git a/virt-convert b/virt-convert
index a7f9a97..2f1ca7a 100755
--- a/virt-convert
+++ b/virt-convert
@@ -1,9 +1,9 @@
-#!/usr/bin/python2 -tt
+#!/usr/bin/env python2 -tt
 #
 # Copyright 2008, 2013, 2014  Red Hat, Inc.
 # Joey Boggs <jboggs@redhat.com>
 # Cole Robinson <crobinso@redhat.com>
 #
 # Copyright 2008 Sun Microsystems, Inc.  All rights reserved.
 # Use is subject to license terms.
 #
diff --git a/virt-install b/virt-install
index 45607fb..4f9cf9e 100755
--- a/virt-install
+++ b/virt-install
@@ -1,9 +1,9 @@
-#!/usr/bin/python2 -tt
+#!/usr/bin/env python2 -tt
 #
 # Copyright 2005-2014 Red Hat, Inc.
 #
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
 # the Free Software Foundation; either version 2 of the License, or
 # (at your option) any later version.
 #
diff --git a/virt-manager b/virt-manager
index d352b90..5fccceb 100755
--- a/virt-manager
+++ b/virt-manager
@@ -1,9 +1,9 @@
-#!/usr/bin/python2 -tt
+#!/usr/bin/env python2 -tt
 #
 # Copyright (C) 2006, 2014 Red Hat, Inc.
 # Copyright (C) 2006 Daniel P. Berrange <berrange@redhat.com>
 #
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
 # the Free Software Foundation; either version 2 of the License, or
 # (at your option) any later version.
diff --git a/virt-xml b/virt-xml
index 4e0848c..eb40bfa 100755
--- a/virt-xml
+++ b/virt-xml
@@ -1,9 +1,9 @@
-#!/usr/bin/python2 -tt
+#!/usr/bin/env python2 -tt
 #
 # Copyright 2013-2014 Red Hat, Inc.
 # Cole Robinson <crobinso@redhat.com>
 #
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
 # the Free Software Foundation; either version 2 of the License, or
 # (at your option) any later version.
