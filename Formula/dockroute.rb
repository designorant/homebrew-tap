class Dockroute < Formula
  desc "Local development proxy for Docker — no more port conflicts"
  homepage "https://github.com/designorant/dockroute"
  url "https://github.com/designorant/dockroute/archive/refs/tags/v2.6.0.tar.gz"
  sha256 "c6e7c7eabc854667ac212848d382835492e276dd07aacf86a09370809e394876"
  license "MIT"

  depends_on "bash"

  def install
    bin.install "bin/dockroute"
    pkgshare.install "share/docker-compose.yml"
  end

  def caveats
    <<~EOS
      To start the proxy:
        dockroute start

      Then configure your Docker Compose projects with Traefik labels.
      See: https://github.com/designorant/dockroute#project-setup
    EOS
  end

  test do
    assert_match "dockroute v#{version}", shell_output("#{bin}/dockroute version")
  end
end
