class TaigaTui < Formula
  desc "Keyboard-driven terminal UI for Taiga Taskboards and Kanban Boards"
  homepage "https://github.com/zeckitoz/taiga-tui"
  url "https://github.com/zeckitoz/taiga-tui/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "4418598e07d28eea7db7dafe9d9f2d69b7892ccf937b0f3613d8f816db3bed0c"
  license "MIT"
  head "https://github.com/zeckitoz/taiga-tui.git", branch: "main"

  depends_on "go" => :build

  def install
    # The same stamp as .goreleaser.yaml. A source tarball has no git
    # history, so the commit and the date of the tag are rendered in.
    ldflags = %W[
      -s -w
      -X github.com/zeckitoz/taiga-tui/internal/version.version=v#{version}
      -X github.com/zeckitoz/taiga-tui/internal/version.commit=8c9baa7f7b3a97ed834adcf52da885e21c2111ad
      -X github.com/zeckitoz/taiga-tui/internal/version.date=2026-11-16T12:41:11Z
    ]
    system "go", "build", *std_go_args(ldflags:), "./cmd/taiga-tui"
  end

  test do
    assert_match "taiga-tui v#{version}", shell_output("#{bin}/taiga-tui --version")
  end
end
