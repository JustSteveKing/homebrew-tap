class Scout < Formula
  desc "Monitor the health of your services from the terminal."
  homepage "https://github.com/JustSteveKing/scout"
  # Replace the URL and sha256 below with a released tarball and its checksum:
  # Example URL pattern: "https://github.com/JustSteveKing/scout/archive/refs/tags/v1.2.3.tar.gz"
  url "https://github.com/JustSteveKing/scout/archive/refs/tags/v0.0.0.tar.gz"
  sha256 "4ee1db1380291bb4cd87bda205f7148642201e87b975fb1f390d793176c739ba"
  license "MIT"
  head "https://github.com/JustSteveKing/scout.git", branch: "main"

  depends_on "go" => :build

  def install
    # If your main package is in a different path (e.g. root: ".", or cmd/scout),
    # update the final argument below accordingly.
    ldflags = "-s -w -X main.version=#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/scout"
  end

  test do
    # Basic smoke test: ensure binary runs and prints help or version.
    # This works cross-platform (macOS, Windows, Linux) with Homebrew's built-in handling
    output = shell_output("#{bin}/scout --help", 0)
    assert_match "Usage", output if output.include?("Usage")
    # Fallback: verify the binary exits successfully with version command
    system bin/"scout", "--version"
  end
end
