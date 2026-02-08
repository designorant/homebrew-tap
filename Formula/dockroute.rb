class Dockroute < Formula
  desc "Local development proxy for Docker — no more port conflicts"
  homepage "https://github.com/designorant/dockroute"
  url "https://github.com/designorant/dockroute/archive/refs/tags/v2.1.0.tar.gz"
  sha256 "8820c2f4710633685fb2cc3a02be11b5147aa4d7740a741843ae8b9e261d19fa"
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
