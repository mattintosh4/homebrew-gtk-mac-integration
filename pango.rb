require 'formula'

class Pango < Formula
  homepage "http://www.pango.org/"
  url "http://ftp.gnome.org/pub/GNOME/sources/pango/1.36/pango-1.36.3.tar.xz"
  sha256 "ad48e32917f94aa9d507486d44366e59355fcfd46ef86d119ddcba566ada5d22"

  bottle do
    sha1 "36247b917430643002dee42a674c5f5d9958511b" => :mavericks
    sha1 "14dd7446da1014ae619eb15863494050df33110c" => :mountain_lion
    sha1 "122324a9601b4186319e82712875c8ab892fd8a9" => :lion
  end

  depends_on 'pkg-config' => :build
  depends_on 'glib'
  depends_on 'mattintosh4/homebrew-gtk-mac-integration/cairo' if build.without? "x11" => "without-x11"
  depends_on 'mattintosh4/homebrew-gtk-mac-integration/harfbuzz'
  depends_on 'fontconfig'
  depends_on :x11 => :recommended
  depends_on 'gobject-introspection'

  fails_with :llvm do
    build 2326
    cause "Undefined symbols when linking"
  end

  def install
    args = %W[
      --disable-dependency-tracking
      --disable-silent-rules
      --prefix=#{prefix}
      --enable-man
      --with-html-dir=#{share}/doc
      --enable-introspection=yes
      --with-xft
    ]

    if build.without? "x11"
      args.delete '--with-xft'
      args << '--without-xft'
    end

    system "./configure", *args
    system "make"
    system "make install"
  end

  test do
    system "#{bin}/pango-querymodules", "--version"
  end
end
