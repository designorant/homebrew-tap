class Ccblocks < Formula
  desc "Time-shift Claude sessions to match your working hours"
  homepage "https://github.com/designorant/ccblocks"
  url "https://github.com/designorant/ccblocks/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "c515cce232070d05d2f6a712085e143f85289c06934c9de9968129a0b37a4d0a"
  license "Apache-2.0"

  depends_on "bash"
  depends_on macos: :catalina

  def install
    # Stage runtime scripts inside libexec so relative lookups stay intact
    libexec.install "ccblocks", "VERSION"
    libexec.install Dir["bin"]
    libexec.install Dir["libexec/*"]
    libexec.install "lib"

    # Install documentation at prefix (mirrors GitHub repo layout)
    prefix.install "LICENSE", "README.md", "CONTRIBUTING.md"

    # Create exec wrapper in bin (Homebrew best practice)
    bin.write_exec_script libexec/"ccblocks"
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
