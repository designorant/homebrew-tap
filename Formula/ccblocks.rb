class Ccblocks < Formula
  desc "Time-shift Claude sessions to match your working hours"
  homepage "https://github.com/designorant/ccblocks"
  url "https://github.com/designorant/ccblocks/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "b297de429fc946313a5d6a64b241a9265080e292e211cff567ec8dccc1b7c8ac"
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
