class Ccblocks < Formula
  desc "Time-shift Claude sessions to match your working hours"
  homepage "https://github.com/designorant/ccblocks"
  url "https://github.com/designorant/ccblocks/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "c515cce232070d05d2f6a712085e143f85289c06934c9de9968129a0b37a4d0a"
  license "Apache-2.0"

  depends_on "bash"
  depends_on macos: :catalina

  def install
    # Install main executable
    bin.install "ccblocks"

    # Install lib at prefix root (daemon uses ../lib from libexec)
    prefix.install "lib"

    # Install supporting scripts to libexec
    libexec.install "bin", "VERSION"

    # Install daemon script from libexec subdirectory
    cd "libexec" do
      libexec.install "ccblocks-daemon.sh"
    end

    # Rewrite the SCRIPT_DIR in ccblocks to point to libexec
    inreplace bin/"ccblocks" do |s|
      s.gsub! 'SCRIPT_DIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"',
              "SCRIPT_DIR=\"#{libexec}\""
    end
  end

  def caveats
    <<~EOS
      To get started:
        ccblocks setup
    EOS
  end

  def uninstall
    # Clean up LaunchAgent/systemd schedulers before Homebrew removes files
    system bin/"ccblocks", "uninstall", "--force"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ccblocks --version")
  end
end
