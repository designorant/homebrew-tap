class Ccblocks < Formula
  desc "Time-shift Claude sessions to match your working hours"
  homepage "https://github.com/designorant/ccblocks"
  url "https://github.com/designorant/ccblocks/archive/refs/tags/v1.1.1.tar.gz"
  sha256 "f162a27f65a26d23ca2a2570358f131b8c8ce6bdc74de4bdf52b357f5c3f629a"
  license "Apache-2.0"

  depends_on "bash"
  depends_on macos: :catalina

  def install
    # Stage runtime payload in libexec (matches repository layout)
    libexec.install Dir["libexec/*"]
    libexec.install "VERSION"

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
