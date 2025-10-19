class Ccblocks < Formula
  desc "Time-shift Claude sessions to match your working hours"
  homepage "https://github.com/designorant/ccblocks"
  url "https://github.com/designorant/ccblocks/archive/refs/tags/v1.0.2.tar.gz"
  sha256 "0a9cf901c73e7d8d3b68e4d5eaa527e3bc97447456368c17c51588f710ece435"
  license "Apache-2.0"

  depends_on "bash"
  depends_on macos: :catalina

  def install
    # Install everything to libexec (maintains repo structure)
    libexec.install Dir["*"]

    # Create exec wrapper in bin (Homebrew best practice)
    # The wrapper execs ccblocks from libexec, making SCRIPT_DIR resolve there
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
