class TaigaTui < Formula
  desc "Keyboard-driven terminal UI for Taiga Taskboards and Kanban Boards"
  homepage "https://github.com/zeckitoz/taiga-tui"
  url "https://github.com/zeckitoz/taiga-tui/archive/refs/tags/v0.2.2.tar.gz"
  sha256 "440bf60bbdfa42e3018f1d49dc77b5f56c3302bac65c1c4d18da7b48b7542007"
  license "MIT"
  head "https://github.com/zeckitoz/taiga-tui.git", branch: "main"

  depends_on "go" => :build

  def install
    # The same stamp as .goreleaser.yaml. A source tarball has no git
    # history, so the commit and the date of the tag are rendered in.
    ldflags = %W[
      -s -w
      -X github.com/zeckitoz/taiga-tui/internal/version.version=v#{version}
      -X github.com/zeckitoz/taiga-tui/internal/version.commit=e653667a989ec74159ecdbace8d67a313fa9b4db
      -X github.com/zeckitoz/taiga-tui/internal/version.date=2026-11-16T12:58:01Z
    ]
    system "go", "build", *std_go_args(ldflags:), "./cmd/taiga-tui"
  end

  test do
    assert_match "taiga-tui v#{version}", shell_output("#{bin}/taiga-tui --version")
  end
end
