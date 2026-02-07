class Dockroute < Formula
  desc "Local development proxy for Docker — no more port conflicts"
  homepage "https://github.com/designorant/dockroute"
  url "https://github.com/designorant/dockroute/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "d88d4d6a0272721433e1fe499406598d5dbc64c5388ed9fb74c9383d379ff2ec"
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
