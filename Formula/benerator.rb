class Benerator < Formula
  desc "Tool for realistic test data generation"
  homepage "https://rapiddweller.github.io/homebrew-benerator/"
  url "https://github.com/rapiddweller/rapiddweller-benerator-ce/releases/download/3.1.0/rapiddweller-benerator-ce-3.1.0-jdk-11-dist.tar.gz"
  sha256 "194feb051ae18cfcd407b8e1668ce9c60561394bc454f9fc9747c274166843bc"

  license "Apache-2.0"
  depends_on "openjdk"
  def install
    # Remove unnecessary files
    rm Dir["bin/*.bat", "bin/pom.xml"]

    # Installs only the 'bin' and 'lib' directories from the tarball
    # Creates the symlinks to 'bin' scripts in /usr/local/bin
    # Creates the symlink to the installation path in /usr/local/opt
    prefix.install Dir["bin", "lib"]
  end

  # opt_prefix is set to the symlink /usr/local/opt/benerator
  def caveats
    <<~EOS
      To use the benerator commands, please set the following environment variables:
      BENERATOR_HOME=#{opt_prefix}

      Use one of the following commands to find the value for JAVA_HOME:
      $(dirname $(readlink $(which javac)))/java_home

      or (more platform independent)

      java -XshowSettings:properties -version 2>&1 > /dev/null | grep 'java.home'

    EOS
  end

  test do
    assert_match "Benerator 3.1.0-jdk-11", shell_output("#{bin}/benerator --version", 2)
  end
end
