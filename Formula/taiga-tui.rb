class TaigaTui < Formula
  desc "Keyboard-driven terminal UI for Taiga Taskboards and Kanban Boards"
  homepage "https://github.com/zeckitoz/taiga-tui"
  url "https://github.com/zeckitoz/taiga-tui/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "0971550601c6492f3ddd52dc84a66b5530eddc7eee0fed378d9561293a8399e9"
  license "MIT"
  head "https://github.com/zeckitoz/taiga-tui.git", branch: "main"

  depends_on "go" => :build

  def install
    # The same stamp as .goreleaser.yaml. A source tarball has no git
    # history, so the commit and the date of the tag are rendered in.
    ldflags = %W[
      -s -w
      -X github.com/zeckitoz/taiga-tui/internal/version.version=v#{version}
      -X github.com/zeckitoz/taiga-tui/internal/version.commit=12fbdc0c0d62077afecc11a5141c46ffdeddbdc2
      -X github.com/zeckitoz/taiga-tui/internal/version.date=2026-11-16T13:24:52Z
    ]
    system "go", "build", *std_go_args(ldflags:), "./cmd/taiga-tui"
  end

  test do
    assert_match "taiga-tui v#{version}", shell_output("#{bin}/taiga-tui --version")
  end
end
