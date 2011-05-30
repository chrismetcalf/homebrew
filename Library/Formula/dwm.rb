require 'formula'

class Dwm < Formula
  url 'http://dl.suckless.org/dwm/dwm-5.8.2.tar.gz'
  homepage 'http://dwm.suckless.org/'
  md5 'f0b422bfeaa812d66c6dd15c3cc92a6b'
  head 'http://hg.suckless.org/dwm'

  depends_on "dmenu"

  def install
    # The dwm default quit keybinding Mod1-Shift-q collides with
    # the Mac OS X Log Out shortcut in the Apple menu.
    inreplace 'config.def.h',
    '{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },',
    '{ MODKEY|ControlMask,           XK_q,      quit,           {0} },'

    # My Colors
    inreplace 'config.def.h', /selbgcolor\[\]\s+=\s+"#0066ff"/, 'selbgcolor[] = "#17335B"'
    inreplace 'config.def.h', /selbordercolor\[\]\s+=\s+"#0066ff"/, 'selbordercolor[] = "#FFFF66"'

    inreplace 'dwm.1', '.B Mod1\-Shift\-q', '.B Mod1\-Control\-q'
    system "make PREFIX=#{prefix} install"
  end

  def patches
    [
      "http://dwm.suckless.org/patches/dwm-5.7.2-attachaside.diff",
      "http://dwm.suckless.org/patches/dwm-5.7.2-urgentborder.diff",
      "https://gist.github.com/raw/978820/7321d69280d78642ecc288b0fa6ea2f5c773c036/dwm-5.8.2-nametag.diff"
    ]
  end

  def caveats
    <<-EOS
    In order to use the Mac OS X command key for dwm commands,
    change the X11 keyboard modifier map using xmodmap (1).

    e.g. by running the following command from $HOME/.xinitrc
    xmodmap -e 'remove Mod2 = Meta_L' -e 'add Mod1 = Meta_L'&

    See also https://gist.github.com/311377 for a handful of tips and tricks
    for running dwm on Mac OS X.
    EOS
  end
end
