class Termpdf < Formula
  TERMPDF_VERSION = "0.3.1"

  desc "Terminal PDF reader built with Rust, ratatui, PDFium, and the kitty image protocol"
  homepage "https://github.com/NiJingzhe/TermPDF"
  version TERMPDF_VERSION
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/NiJingzhe/TermPDF/releases/download/v#{TERMPDF_VERSION}/termpdf-#{TERMPDF_VERSION}-aarch64-apple-darwin.tar.gz"
      sha256 "08597b5241d72c5bd4dd4c4fd0aac57e138ce78d678984d8f8f8880502d389d4"
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
