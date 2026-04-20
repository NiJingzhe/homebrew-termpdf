class Termpdf < Formula
  desc "Terminal PDF reader built with Rust, ratatui, PDFium, and the kitty image protocol"
  homepage "https://github.com/NiJingzhe/TermPDF"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/NiJingzhe/TermPDF/releases/download/v0.1.0/termpdf-0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "ee705e62c7c3bea33e8be1fe44db71b8386e39f4af5b6e9ce586a20be0c960f6"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/NiJingzhe/TermPDF/releases/download/v0.1.0/termpdf-0.1.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "17245392c2204a58e51ea4301d18af410b655a576068e9cbfc1b8c3229ca9bbe"
    end

    on_arm do
      url "https://github.com/NiJingzhe/TermPDF/releases/download/v0.1.0/termpdf-0.1.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "21865e449f661d1e0d1755e07c5843a87f7add41ae29c33bfbdc53f287053fa9"
    end
  end

  def install
    libexec.install "termpdf"

    if OS.mac?
      libexec.install "libpdfium.dylib"
    else
      libexec.install "libpdfium.so"
    end

    (bin/"termpdf").write <<~EOS
      #!/bin/bash
      exec "#{libexec}/termpdf" "$@"
    EOS
  end

  test do
    assert_match "TermPDF", shell_output("#{bin}/termpdf --help")
  end
end
