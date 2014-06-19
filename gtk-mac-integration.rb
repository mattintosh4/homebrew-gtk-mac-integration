require 'formula'

class GtkMacIntegration < Formula
  homepage 'http://gtk.org/'
  url      'http://ftp.acc.umu.se/pub/gnome/sources/gtk-mac-integration/2.0/gtk-mac-integration-2.0.5.tar.xz'
  sha256   '6c4ff7501d7ff35e49068052d80fcf76ce494e5953c5f3967e4958b1b0c67b9f'
  version  '2.0.5'

  depends_on 'pkg-config' => :build
  depends_on 'xz'
  depends_on 'gtk+-quartz'

  patch do
    url  'http://git.gnome.org/browse/gtk-osx/plain/patches/0001-Fix-unhandled-exception-from-attempting-to-access-me.patch'
    sha1 '1c99223c1a21e49836d1f1c95c0d098616077037'
  end

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules"
    system "make install"
  end
end

