class Ccblocks < Formula
  desc "Time-shift Claude sessions to match your working hours"
  homepage "https://github.com/designorant/ccblocks"
  url "https://github.com/designorant/ccblocks/archive/refs/tags/v0.0.0.tar.gz"
  sha256 "d5558cd419c8d46bdc958064cb97f963d1ea793866414c025906ec15033512ed"
  license "Apache-2.0"

  depends_on "bash"
  depends_on macos: :catalina

  def install
    # Install main executable
    bin.install "ccblocks"

    # Install supporting scripts and libraries to libexec
    libexec.install "bin", "lib", "VERSION"

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
