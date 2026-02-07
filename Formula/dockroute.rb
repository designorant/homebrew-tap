class Dockroute < Formula
  desc "Local development proxy for Docker — no more port conflicts"
  homepage "https://github.com/designorant/dockroute"
  url "https://github.com/designorant/dockroute/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "3d6e72e819e2cd2b166b1c69e69c54a554ec7d315cb64913e05e4530c1819cb6"
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
