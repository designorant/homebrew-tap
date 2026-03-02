class Dockroute < Formula
  desc "Local development proxy for Docker — no more port conflicts"
  homepage "https://github.com/designorant/dockroute"
  url "https://github.com/designorant/dockroute/archive/refs/tags/v2.5.0.tar.gz"
  sha256 "8cf943297c30d6d625122dea41d81a394c394124fe5e169fcabef83d7fbb01c5"
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
