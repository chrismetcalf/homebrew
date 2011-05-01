require 'formula'

class Gvim <Formula
  @url='ftp://ftp.vim.org/pub/vim/unix/vim-7.3.tar.bz2'
  @homepage='http://www.vim.org/'
  @md5='5b9510a17074e2b37d8bb38ae09edbf2'

  depends_on 'gtk+'

  def install
    system "./configure",
      "--with-x",
      "--disable-netbeans",
      "--enable-gui=gtk2",
      "--with-mac-arch=x86_64",
      "--enable-rubyinterp",
      "--enable-pythoninterp",
      "--enable-perlinterp",
      "--enable-multibyte",
      "--with-features=huge",
      "--disable-darwin",
      "--disable-debug",
      "--prefix=#{prefix}",
      "--disable-dependency-tracking",
      "--enable-fndir=#{share}/zsh/functions",
      "--enable-scriptdir=#{share}/zsh/scripts"

    inreplace "src/gui.c",
      "#if defined(UNIX) && !defined(__BEOS__) && !defined(MACOS_X)",
      "#if defined(UNIX) && !defined(__BEOS__) && !defined(MACOS_X) && !defined(__APPLE__)"

    system "make install"
  end
end
