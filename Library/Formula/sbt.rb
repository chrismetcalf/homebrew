require 'formula'

class Sbt < Formula
  url "http://simple-build-tool.googlecode.com/files/sbt-launch-0.7.7.jar"
  homepage 'http://github.com/harrah/xsbt/'
  version '0.7.7'
  md5 '0cce0d5ade30a41b91e05705a9346b71'

  def install
    (bin+'sbt').write <<-EOS.undent
      #!/bin/sh
      test -f ~/.sbtconfig && . ~/.sbtconfig
      exec java -Xmx512M ${SBT_OPTS} -jar #{libexec}/sbt-launch-0.7.7.jar "$@"
    EOS

    libexec.install Dir['*']
  end

  def caveats;  <<-EOS.undent
    You can use $SBT_OPTS to pass additional JVM options to SBT.
    For convenience, this can specified in `~/.sbtconfig`.

    For example:
        SBT_OPTS="-XX:+CMSClassUnloadingEnabled -XX:MaxPermSize=256M"
    EOS
  end
end
