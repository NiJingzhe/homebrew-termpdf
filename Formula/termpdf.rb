class Termpdf < Formula
  TERMPDF_VERSION = "0.4.0"

  desc "Terminal PDF reader built with Rust, ratatui, PDFium, and the kitty image protocol"
  homepage "https://github.com/NiJingzhe/TermPDF"
  version TERMPDF_VERSION
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/NiJingzhe/TermPDF/releases/download/v#{TERMPDF_VERSION}/termpdf-#{TERMPDF_VERSION}-aarch64-apple-darwin.tar.gz"
      sha256 "17e51b3067738f1e7a4debd078f1cce8241fcce29ba4c3ed608021121869f6b8"
    end
  end

  def install
    libexec.install "termpdf"

    libexec.install "libpdfium.dylib"

    (bin/"termpdf").write <<~EOS
      #!/bin/bash
      exec "#{libexec}/termpdf" "$@"
    EOS
  end

  test do
    assert_match "Terminal PDF viewer", shell_output("#{bin}/termpdf --help")
  end
end
