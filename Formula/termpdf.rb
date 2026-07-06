class Termpdf < Formula
  TERMPDF_VERSION = "0.3.0"

  desc "Terminal PDF reader built with Rust, ratatui, PDFium, and the kitty image protocol"
  homepage "https://github.com/NiJingzhe/TermPDF"
  version TERMPDF_VERSION
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/NiJingzhe/TermPDF/releases/download/v#{TERMPDF_VERSION}/termpdf-#{TERMPDF_VERSION}-aarch64-apple-darwin.tar.gz"
      sha256 "00235f958cba6b71732b364bed02f87aaac0fbc080175775af2f1392babae195"
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
    assert_match "TermPDF", shell_output("#{bin}/termpdf --help")
  end
end
